//
//  InboxIndepth.h
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/22/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InboxIndepth : UITableViewController

- (IBAction)refresh:(id)sender;


@property (strong, nonatomic) NSMutableArray * friendsGoing;
@property (strong, nonatomic) NSMutableArray * responseObjectJSON;

@end
