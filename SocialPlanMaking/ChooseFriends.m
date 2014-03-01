//
//  ChooseFriends.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/22/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "ChooseFriends.h"

@interface ChooseFriends ()
@property (nonatomic,strong) NSArray * friends;

@end

@implementation ChooseFriends

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"ChooseFriends VC loaded");
    
    self.friends = @[@"Clay Toboloka",@"Richie Sweeney",@"Boris Veltman",@"Surge Saeed",@"Ali Kassam",@"Ahsan Daredia",@"Ali Sajun",@"Fahim Pyarali"];
    
    
    self.idsOfFriends = [NSMutableArray array];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    /* Test arrayPassing */
//    NSNumber * firstElement = self.schedule[0][0];
//    NSLog(@"firstElement: %@", firstElement);
    
    //[self.tableView setAllowsSelection:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor orangeColor];

    // Configure the cell...
    cell.textLabel.text = self.friends[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAt");
    
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        //grab the userID at the indexPath
        int id = 3;
        
        //append the userID to idOfFriends
        [self.idsOfFriends  addObject:[NSNumber numberWithInt:id]];

    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if([self.idsOfFriends count] != 0 )
        {
            [self.idsOfFriends removeLastObject];
        }
    }
    
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didUNNNNSelect");
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.accessoryType = UITableViewCellAccessoryNone;
}

- (IBAction)Broadcast:(id)sender {
    NSLog(@"Broadcast button was pushed");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    //get user id
    params[@"user_id"] = [defaults objectForKey:@"user_id"];
    
    //get auth tok
    params[@"auth_token"] = [defaults objectForKey:@"auth_token"];
    
    //send activities/location
    
    
    //send the schedule
    params[@"time"] =  self.schedule;
    
    //send list of friends
    self.idsOfFriends;
    
    //Networking code
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:<#(NSString *)#> parameters:<#(NSDictionary *)#> constructingBodyWithBlock:<#^(id<AFMultipartFormData> formData)block#> success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>]
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
