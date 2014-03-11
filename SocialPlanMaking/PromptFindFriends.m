//
//  PromptFindFriends.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 2/1/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "PromptFindFriends.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "FindFriends.h"

@interface PromptFindFriends ()

@end

@implementation PromptFindFriends

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

- (IBAction)FindFriendsFacebookBtnPushed:(id)sender {
    NSLog(@"FindFriendsFacebookBtn pushed");
    self.findFBBtn.enabled = NO;

    [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error)
                                  {
                                      NSLog(@"access token data is: %@", session.accessTokenData.accessToken);
                                      //Store the access Token
                                      self.accessToken = session.accessTokenData.accessToken;
                                      
                                      //Update the session
                                      // Retrieve the app delegate
                                      AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                                      // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
                                      [appDelegate sessionStateChanged:session state:state error:error];
                                      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                      
                                      if(self.accessToken)
                                      {
                                          [defaults setObject:self.accessToken forKey:@"accessToken"];
                                          [defaults synchronize];
                                          [self sendFBToken];
                                      }
                                  }];
    
}


-(void)sendFBToken
{
    //make a network call to the server with token info
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *parameters = @{@"user_id": [defaults objectForKey:@"user_id"],
                                 @"auth_token": [defaults objectForKey: @"auth_token"],
                                 @"fb_token" : [defaults objectForKey:@"accessToken"]
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://socialplanmaking.herokuapp.com/find_facebook_friends/findfriends" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Success");
         //NSLog(@"Response: %@",responseObject);
         self.friends = responseObject[@"friended"];
         self.invites = responseObject[@"not_friended"];
         
         NSLog(@"self.friends: %i",[self.friends count]);
         NSLog(@"self.invites: %i",[self.invites count]);
         [self performSegueWithIdentifier:@"ShowFriends" sender:nil];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@",[error localizedDescription]);
     }];
}

/* Send accessToken to FindFriends VC */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowFriends"]) {
        NSLog(@"prepareForSeg Showfriends");
        self.findFBBtn.enabled = YES;
        FindFriends * destVC = [segue destinationViewController];
        destVC.accessToken = self.accessToken;
        destVC.friends = self.friends;
        destVC.invites = self.invites;
    }
}

- (IBAction)FriendSkipBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
