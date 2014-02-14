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
}



-(IBAction)hideKeyBoard
{
    NSLog(@"hideKeyBoard method");
    [self.activeTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSLog(@"textFieldShouldClear");
    
    switch (textField.tag) {
        case 0:
            self.Loc1.text = @"";
            break;
        case 1:
            self.Loc2.text = @"";
            break;
        case 2:
            self.Loc3.text = @"";
            break;
        default:
            break;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self setUpAccessViewForKeyBoard:textField];
}

-(void)setUpAccessViewForKeyBoard:(UITextField *)textField
{
    //create toolbar and hide button
    UIToolbar * myTlbr = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem * hideBtn = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleBordered target:self action:@selector(hideKeyBoard)];
    self.activeTextField = textField;
    [hideBtn setTitle:@"Close"];
    //set up flexibleSpacing
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //add items to toolbar
    [myTlbr setItems:[NSArray arrayWithObjects: flexibleSpace,hideBtn, nil]];
    //Add UIToolbar to keyboard
    [textField setInputAccessoryView:myTlbr];
}

- (IBAction)Cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

    /* Delegate method from Activities Suggestion */
-(void)childViewController:(Activities *)tableViewController didSendString:(NSString *)value
{
    NSLog(@"This is the string I see: %@",value);
    NSArray *suggestionsArray = [value componentsSeparatedByString:@"@"];
    
    [self StripSuggestionWhitespace:suggestionsArray];
}

-(void)StripSuggestionWhitespace:(NSArray *) suggestionsArray
{
    //Strip beginning and ending white space
    NSString * act = suggestionsArray[0];
    NSString * loc = suggestionsArray[1];
    
    NSString * trimmedAct = [act stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * trimmedLoc = [loc stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray * suggestionsArrayNoWhiteSpace = @[trimmedAct, trimmedLoc];
    
    [self fillInRowWithSuggestion: suggestionsArrayNoWhiteSpace];
}

-(void)fillInRowWithSuggestion: (NSArray *)suggestion
{
    //if act1 has text dont do antyhing
    
    if ([self.Act1.text isEqualToString:@""]) {
        self.Act1.text = [suggestion objectAtIndex:0];
        self.Loc1.text = [suggestion objectAtIndex:1];
        [self.Act1 becomeFirstResponder];
    }else if ([self.Act2.text isEqualToString:@""])
    {
        self.Act2.text = [suggestion objectAtIndex:0];
        self.Loc2.text = [suggestion objectAtIndex:1];
        [self.Act2 becomeFirstResponder];
    }else if([self.Act3.text isEqualToString:@""])
    {
        self.Act3.text = [suggestion objectAtIndex:0];
        self.Loc3.text = [suggestion objectAtIndex:1];
        [self.Act3 becomeFirstResponder];
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


/*
 //Text Manipulation Code
 
 -(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 {
 NSLog(@"text field is changing");
 return YES;
 }
 

 
 */
