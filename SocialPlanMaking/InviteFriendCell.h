//
//  InviteFriendCell.h
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/24/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteFriendCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *Name;
- (IBAction)InviteFriendBtn:(id)sender;

@end
