//
//  FindFriends.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/24/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "FindFriends.h"
#import "FindFriendsCell.h"
#import "InviteFriendCell.h"

@interface FindFriends ()
@property (nonatomic,strong) NSArray * listOfFriends;
@property (nonatomic,strong) NSArray * listOfFriendsToInvite;
@end

@implementation FindFriends

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.accessToken = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.listOfFriends = @[@"Richie Sweeney",@"Clay Tobolka", @"Imran Jeddy"];
    self.listOfFriendsToInvite = @[@"Neal Bh",@"Chase Fieger", @"Raheel Poonja"];
    
}

/* Get list of friends */
-(void) viewWillAppear:(BOOL)animated
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * parameters = @{@"accessToken" : self.accessToken};
    
    //Networking code
    /*
    [manager GET:@"http://" parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    */
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
    
    NSLog(@"complete list is: %i", [self.listOfFriends count] +[self.listOfFriendsToInvite count] + 1);
    
    return ([self.listOfFriends count] +[self.listOfFriendsToInvite count] + 1);
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.row < [self.listOfFriends count])
    {
        static NSString *CellIdentifier = @"Friend";
        FindFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        cell.Name.text = self.listOfFriends[indexPath.row];
        return cell;
    }
    else if (indexPath.row == [self.listOfFriends count]) {
        static NSString *CellIdentifier = @"Friend";
        FindFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

        // Configure the cell...
        cell.Name.text = @"Invite Friends";
        [cell setBackgroundColor:[UIColor orangeColor]];
        return cell;
    }
    else //Invited Friends List
    {
        static NSString *CellIdentifier = @"FriendToInvite";
        InviteFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        
        // Configure the cell...
        cell.Name.text = self.listOfFriends[(indexPath.row - [self.listOfFriends count] -1 )];
        return cell;
    }
    
    
}



- (IBAction)friendAllBtn:(id)sender {
    NSLog(@"Friend All btn pushed");
}


- (IBAction)DoneBtn:(id)sender {
    NSLog(@"Skip btn psuhed");
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
