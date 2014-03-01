//
//  ChooseFriends.h
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/22/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseFriends : UITableViewController
- (IBAction)Broadcast:(id)sender;

@property NSMutableArray * schedule;
@property NSMutableArray * idsOfFriends;
@property NSMutableArray * activities;
@property (nonatomic,strong) NSMutableArray * friends;


@end
