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
    NSLog(@"Findfirneds");
    NSLog(@"%i",[self.friends count]);
    NSLog(@"%i",[self.invites count]);
    
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
    NSLog(@"numberOfRows: %i", ([self.friends count] + [self.invites count] + 1 ));
    
    return ([self.friends count] + [self.invites count] + 1 );
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.row < [self.friends count])
    {
        static NSString *CellIdentifier = @"Friend";
        FindFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        NSDictionary * dict = self.friends[indexPath.row];
        cell.Name.text =dict[@"name"];
        return cell;
    }
    else if (indexPath.row == [self.friends count]) {
        static NSString *CellIdentifier = @"Friend";
        FindFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

        // Configure the cell...
        cell.Name.text = @"Invite Friends";
        [cell setBackgroundColor:[UIColor orangeColor]];
        return cell;
    }
    else //Invited Friends List
    {
        NSLog(@"Else sstatement");
        static NSString *CellIdentifier = @"FriendToInvite";
        InviteFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        
        // Configure the cell...
        NSDictionary * otherDict = self.invites[(indexPath.row - [self.friends count] -1 )];
        cell.Name.text = otherDict[@"name"];
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
