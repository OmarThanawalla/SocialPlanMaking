//
//  Activities.h
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/22/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ActivitiesDelegate;

@interface Activities : UITableViewController
@property (nonatomic, weak) id<ActivitiesDelegate> delegate;

@end


// 3. Definition of the delegate's interface
@protocol ActivitiesDelegate <NSObject>
- (void)childViewController:(Activities*)tableViewController
             didSendString:(NSString *)value;
@end