//
//  SignUp.h
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 2/1/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUp : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *Fullname;
@property (strong, nonatomic) IBOutlet UITextField *EmailAddress;
@property (strong, nonatomic) IBOutlet UITextField *Password;
- (IBAction)register:(id)sender;



@end
