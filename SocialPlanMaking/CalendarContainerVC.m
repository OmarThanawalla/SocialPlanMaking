//
//  CalendarContainerVC.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 2/28/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "CalendarContainerVC.h"
#import "ChooseFriends.h"

@interface CalendarContainerVC ()

@end

@implementation CalendarContainerVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@",    segue.identifier);
    Calendar * destVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"containCalendar"]) {
        self.myCalObj = destVC;
    }
    else if ([segue.identifier isEqualToString:@"pushChooseFriends"])
    {
        ChooseFriends * myChFri =  segue.destinationViewController;
        myChFri.schedule = self.myCalObj.schedule;
    }
}

@end
