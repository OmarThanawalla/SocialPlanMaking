//
//  PickActivitiesViewController.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/24/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "PickActivitiesViewController.h"
#import "Activities.h"

@interface PickActivitiesViewController ()
@property (nonatomic, strong) Activities * myActivities;
@property (nonatomic, assign) BOOL row1;
@property (nonatomic, assign) BOOL row2;
@property (nonatomic, assign) BOOL row3;

@end

@implementation PickActivitiesViewController

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
    NSLog(@"PickActivitiesVC loaded");
    self.row1 = YES;
    self.row2 = YES;
    self.row3 = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


    /* Delegate method from Activities Suggestion */
-(void)childViewController:(Activities *)tableViewController didSendString:(NSString *)value
{
    NSLog(@"This is the string I see: %@",value);
    NSArray *suggestionsArray = [value componentsSeparatedByString:@"@"];
    
    [self fillInRowWithSuggestion: suggestionsArray];
    
}

-(void)fillInRowWithSuggestion: (NSArray *)suggestion
{
    if (self.row1) {
        self.Act1.text = [suggestion objectAtIndex:0];
        self.Loc1.text = [suggestion objectAtIndex:1];
        self.row1 = NO;
    }else if (self.row2)
    {
        self.Act2.text = [suggestion objectAtIndex:0];
        self.Loc2.text = [suggestion objectAtIndex:1];
        self.row2 = NO;
    }else if(self.row3)
    {
        self.Act3.text = [suggestion objectAtIndex:0];
        self.Loc3.text = [suggestion objectAtIndex:1];
        self.row3 = NO;
    }
    else{
        //do nothing, everyone is full
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowSuggestions"])
    {
        self.myActivityController = segue.destinationViewController;
        self.myActivityController.delegate = self;
    }
}

@end
