//
//  Inbox.h
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/22/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Inbox : UITableViewController
@property (nonatomic, strong) NSMutableArray * temp;

- (IBAction)refresh:(id)sender;

@end
