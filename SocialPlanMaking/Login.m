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
    
     [manager GET:@"http://socialplanmaking.herokuapp.com/login" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         /* SUCCESS */
         NSLog(@"JSON: %@", responseObject);
         [self dismissViewControllerAnimated:YES completion:nil];

         // Store the data
         NSString *auth_token = [responseObject[0] objectForKey:@"auth_token"];
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:auth_token forKey:@"auth_token"];
         [defaults synchronize];

     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         /* FAILURE */
         NSLog(@"Error: %@", [error localizedDescription]);
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Fail"
                                                         message:@"Something went wrong, please try again later or text the co-founder at 469.569.7074"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
         [alert show];
         
     }];
}





@end
