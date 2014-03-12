//
//  Friends.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 3/11/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "Friends.h"
#import "PendingFriendRequestsViewController.h"

@interface Friends ()

@end

@implementation Friends

- (IBAction)LogOut:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"auth_token"];
    [defaults synchronize];
    
    UITabBarController * myTabBar = [self tabBarController];
    self.tabBarController.selectedIndex = 0;
}

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
    //Networking code
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    //get auth tok
    params[@"auth_token"] = [defaults objectForKey:@"auth_token"];
    
    [manager GET:@"http://socialplanmaking.herokuapp.com/get_friends_pending_approval" parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"ResponseObject: %@",responseObject);
             self.FriendRequests = responseObject;
             [self.tableView reloadData];
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", [error localizedDescription]);
         }];

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
    return ([self.staticDataArr count] + 1 + [self.Friends count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.row == 0) {
        cell.textLabel.text = self.staticDataArr[indexPath.row];
    }else if (indexPath.row == 1)
    {
        int friendCount = [self.FriendRequests count];
        NSString * stringFriendCount = [NSMutableString stringWithFormat:@"%d",friendCount];
        NSString * lbl = @"Friend Requests: ";
        
        cell.textLabel.text = [NSString stringWithFormat:stringFriendCount,lbl];
    }
    else
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
    else if (indexPath.row == 1)
    {
        //Dipslay list of pending friend requests
        [self performSegueWithIdentifier:@"displayPending" sender:nil];
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"displayPending"])
    {
        PendingFriendRequestsViewController * destVC = segue.destinationViewController;
        destVC.pendingRequests = self.FriendRequests;
    }
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSLog(@"prepareForSegue: %@",    segue.identifier);
//    Calendar * destVC = segue.destinationViewController;
//    if ([segue.identifier isEqualToString:@"containCalendar"]) {
//        self.myCalObj = destVC;
//    }
//    else if ([segue.identifier isEqualToString:@"pushChooseFriends"])
//    {
//        ChooseFriends * myChFri =  segue.destinationViewController;
//        myChFri.schedule = self.myCalObj.schedule;
//        myChFri.activities = self.activities;
//    }
//    
//}

@end
