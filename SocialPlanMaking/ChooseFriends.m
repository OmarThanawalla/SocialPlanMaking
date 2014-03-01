//
//  ChooseFriends.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/22/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "ChooseFriends.h"

@interface ChooseFriends ()

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
    
    self.idsOfFriends = [NSMutableArray array];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    //get user id
    params[@"user_id"] = [defaults objectForKey:@"user_id"];
    
    //get auth tok
    params[@"auth_token"] = [defaults objectForKey:@"auth_token"];
    
    
    
    //Networking code
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager GET:@"http://socialplanmaking.herokuapp.com/get_friends/friends" parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"ResponseObject %@",responseObject);
             NSLog(@"The size of responseObject is: %i",[responseObject count]);
             self.friends = responseObject;
             [self.tableView reloadData];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error");
             NSLog(@"Localized error: %@",[error localizedDescription]);
         }];
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
    NSDictionary * friendObj =  self.friends[indexPath.row];
    NSLog(@"The name is: %@",friendObj[@"friend_name"]);
    cell.textLabel.text = friendObj[@"friend_name"];
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
        NSDictionary * friendObj = self.friends[indexPath.row];
        NSNumber * myNumber = friendObj[@"friend_id"];
        
        
        //append the userID to idOfFriends
        [self.idsOfFriends  addObject:myNumber];

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
    assert(self.activities != nil);
    params[@"activities"] = self.activities;
    
    //send the schedule
    NSMutableArray * oneD = [self convertTimeToOneArray:self.schedule];
    params[@"time"] =  oneD;
    
    //send list of friends
    params[@"friends"] = self.idsOfFriends;
    
    //
    NSLog(@"The count on activities: %i",[params[@"activities"] count]);
   
    NSLog(@"params[friends]: %@",params[@"friends"]);
    
    //Networking code
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager GET:@"http://socialplanmaking.herokuapp.com/create_event/event" parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"ResponseObject");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error");
    }];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSMutableArray *) convertTimeToOneArray: (NSMutableArray *) array
{
    NSMutableArray * outbound = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        for (int j = 0; j < [array[0] count] ; j++) {
            NSMutableArray * temp1 = array[i];
            NSNumber *value = temp1[j];
            [outbound addObject:value];
            
        }
    }
    
    return outbound;
}

@end
