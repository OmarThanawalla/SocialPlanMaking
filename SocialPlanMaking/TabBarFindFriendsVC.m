//
//  TabBarFindFriendsVC.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 2/2/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "TabBarFindFriendsVC.h"

@interface TabBarFindFriendsVC ()

@end

@implementation TabBarFindFriendsVC

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
- (IBAction)FindFriendsBtnPushed:(id)sender {
    NSLog(@"Find Friends from Facebook btn pushed - tab bar");
    [self performSegueWithIdentifier:@"ShowFriendsTabBar" sender:nil];
    
}

@end
