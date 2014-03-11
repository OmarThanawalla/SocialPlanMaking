//
//  SignUp.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 2/1/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//
#import "KeychainItemWrapper.h"
#import "SignUp.h"
#import "FindFriends.h"

@interface SignUp ()

@end

@implementation SignUp

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)register:(id)sender {
    NSLog(@"Register Btn pushed");
    
    //Networking Code
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"Fullname": self.Fullname.text,
                                 @"EmailAddress": self.EmailAddress.text,
                                 @"Password" : self.Password.text
                                 };
    
    [manager GET:@"http://socialplanmaking.herokuapp.com/create_user" parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        /* SUCCESS */
        NSLog(@"JSON: %@", responseObject);
     
        [self performSegueWithIdentifier:@"PromptFindFriends" sender:nil];
   
        //store the email and password in the KeyChain or NSUserDefaults. NOTE: I imported the KeychainItemWrapper and linked Secuirty.framework
        KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"GoGoLoginData" accessGroup:nil];
        [keychain setObject:self.EmailAddress.text forKey:(__bridge id) kSecAttrAccount];
        [keychain setObject:self.Password.text forKey:(__bridge id)kSecValueData];
        
        // Store the data
        NSString *auth_token = [responseObject[0] objectForKey:@"auth_token"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.Fullname.text forKey:@"Fullname"];
        [defaults setObject:auth_token forKey:@"auth_token"];
        [defaults synchronize];
        
    }
        /*  FAILURE */
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", [error localizedDescription]);
              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed"
                                                              message:@"Something went wrong, the servers are really busy. Please try again later or text the co-founder at 469.569.7074"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
              [alert show];
              
    }];

}

@end
