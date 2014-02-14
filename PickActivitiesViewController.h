//
//  PickActivitiesViewController.h
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/24/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activities.h"

@interface PickActivitiesViewController : UIViewController <ActivitiesDelegate,UITextFieldDelegate>
@property (strong, nonatomic) Activities *myActivityController;
@property (strong, nonatomic) IBOutlet UITextField *Act1;
@property (strong, nonatomic) IBOutlet UITextField *Act2;
@property (strong, nonatomic) IBOutlet UITextField *Act3;

@property (strong, nonatomic) IBOutlet UITextField *Loc1;
@property (strong, nonatomic) IBOutlet UITextField *Loc2;
@property (strong, nonatomic) IBOutlet UITextField *Loc3;

@property (strong, nonatomic) UITextField *activeTextField;

- (IBAction)Cancel:(id)sender;



@end
