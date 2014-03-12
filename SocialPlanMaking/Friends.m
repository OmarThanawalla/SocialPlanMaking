//
//  Friends.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 3/11/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "Friends.h"

@interface Friends ()

@end

@implementation Friends

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadFriends];
    [self loadFriendsNetworkCall];
}

-(void) loadFriendsNetworkCall
{
    
}

-(void) loadFriends
{
    self.staticDataArr = [[NSMutableArray alloc] initWithObjects:@"Find Friends on Facebook", nil];
    self.FriendRequests = [[NSMutableArray alloc] init];
    self.Friends = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return ([self.staticDataArr count] + [self.FriendRequests count] + [self.Friends count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.row == 0) {
        cell.textLabel.text = self.staticDataArr[indexPath.row];
    }else
    {
        //Friend Request Cell
        
        //Friends Cell
    }
    
    return cell;
}

- (void)tableView:(UITableView *)sender didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        //Find FB Friends
        NSLog(@"perform segue FindFBFriends");
        [self performSegueWithIdentifier:@"FindFBFriends" sender:nil];
    }

}

@end
