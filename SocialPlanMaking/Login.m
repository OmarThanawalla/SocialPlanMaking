//
//  Login.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/23/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "Login.h"
#import "KeychainItemWrapper.h"

@interface Login ()
@property (nonatomic, assign) BOOL firstTime;
@property (nonatomic, assign) BOOL goOnce;

@end

@implementation Login

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"Login: viewDidLoad");
    self.firstTime = YES;
    self.goOnce = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LogIn:(id)sender {
    NSLog(@"LogIn btn pushed");
    
    NSDictionary * params = @{@"EmailAddress": self.EmailAddress.text,
                              @"Password": self.Password.text};
    
    
    //Networking code
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
     [manager GET:@"http://socialplanmaking.herokuapp.com/login/login2" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         /* SUCCESS */
         NSLog(@"JSON: %@", responseObject);
         [self dismissViewControllerAnimated:YES completion:nil];
        //Store the email and password in Apple Keychain
        
         
         
         // Store the data
         NSString *auth_token = [responseObject[0] objectForKey:@"auth_token"];
         NSString *user_id = [responseObject[0] objectForKey:@"user_id"];
         
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:auth_token forKey:@"auth_token"];
         [defaults setObject:user_id forKey:@"user_id"];
         [defaults synchronize];

         
         /*
         
         KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"GoGoLoginData" accessGroup:nil];
         [keychain setObject:self.EmailAddress.text forKey:(__bridge id) kSecAttrAccount];
         [keychain setObject:self.Password.text forKey:(__bridge id)kSecValueData];
    
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:auth_token forKey:@"auth_token"];
         [defaults setObject:user_id forKey:@"user_id"];
         [defaults synchronize];
          
          */
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         /* FAILURE */
         NSLog(@"Error: %@", error);
     }];
    
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    //self.profilePictureView.profileID = user.id;
    //self.nameLabel.text = user.name;
    NSLog(@"The user.name is: %@",user.name);
    NSLog(@"The user.first_name is: %@",user.first_name);
    NSLog(@"The user.last_name is: %@",user.last_name);
    NSLog(@"The user.id is: %@", user.id);
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    //    if (self.firstTime && self.goOnce) {
    //        [self performSegueWithIdentifier:@"InviteFriends" sender:self];
    //        self.goOnce = NO;
    //    }
    
    
}


// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}




@end
