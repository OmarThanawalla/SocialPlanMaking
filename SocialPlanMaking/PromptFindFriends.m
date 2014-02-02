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
                                      
                                      [self performSegueWithIdentifier:@"ShowFriends" sender:nil];
                                  }];
    
    //[self performSegueWithIdentifier:@"ShowFriends" sender:nil];
}

/* Send accessToken to FindFriends VC */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowFriends"]) {
        FindFriends * destVC = [segue destinationViewController];
        destVC.accessToken = self.accessToken;
    }
}

- (IBAction)FriendSkipBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
