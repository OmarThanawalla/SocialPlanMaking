//
//  ActivityInformationCell.h
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/28/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityInformationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *Activity1;
@property (strong, nonatomic) IBOutlet UILabel *Activity2;
@property (strong, nonatomic) IBOutlet UILabel *Activity3;

@property (strong, nonatomic) IBOutlet UILabel *vote1;
@property (strong, nonatomic) IBOutlet UILabel *vote2;
@property (strong, nonatomic) IBOutlet UILabel *vote3;
@property (strong, nonatomic) IBOutlet UILabel *initiator;

@end
