//
//  PromptFindFriends.h
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 2/1/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptFindFriends : UIViewController
@property (nonatomic,strong) NSString * accessToken;
- (IBAction)FindFriendsFacebookBtnPushed:(id)sender;
- (IBAction)FriendSkipBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *findFBBtn;

@property (strong, nonatomic) NSMutableArray * friends;
@property (strong, nonatomic) NSMutableArray * invites;
@end
