//
//  FindFriends.h
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/24/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindFriends : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *topLeftBtn;
@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSMutableArray * friends;
@property (strong, nonatomic) NSMutableArray * invites;


- (IBAction)friendAllBtn:(id)sender;

@end
