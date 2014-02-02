//
//  PromptFindFriends.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 2/1/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "PromptFindFriends.h"

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
    
    
    /*
     Get auth from user 
     get access token
     send accesstoken to the server and uniqueID token
     get back json
     pass json data to FindFriends.m
     */
    
    
    [self performSegueWithIdentifier:@"ShowFriends" sender:nil];
}

- (IBAction)FriendSkipBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
