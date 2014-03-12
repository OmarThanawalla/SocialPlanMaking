//
//  Friends.h
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 3/11/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Friends : UITableViewController

@property (nonatomic, strong) NSMutableArray * staticDataArr;
@property (nonatomic, strong) NSMutableArray * FriendRequests;
@property (nonatomic, strong) NSMutableArray * Friends;
- (IBAction)LogOut:(id)sender;

@end
