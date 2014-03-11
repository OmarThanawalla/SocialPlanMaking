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
        NSLog(@"Facebook id: %@",dict[@"id"]);
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
        static NSString *CellIdentifier = @"FriendToInvite";
        InviteFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        
        // Configure the cell...
        NSDictionary * otherDict = self.invites[(indexPath.row - [self.friends count] -1 )];
        cell.Name.text = otherDict[@"name"];
        NSLog(@"Facebook id: %@",otherDict[@"id"]);
        
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //FindFriendsCell * myCell = [tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.row < [self.friends count])
    {
        
        NSDictionary * dict = self.friends[indexPath.row];
        NSLog(@"This is dict: %@",dict);
        NSLog(@"assigning: %@",dict[@"id"]);
        self.friendID = dict[@"id"];
        NSLog(@"This is myNumber: %@", self.friendID);
        
        [self callServerToMakeFriends];
        FindFriendsCell * myCell = (FindFriendsCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        myCell.backgroundColor = [UIColor greenColor];
    }
}

-(void)callServerToMakeFriends
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    //get auth tok
    params[@"auth_token"] = [defaults objectForKey:@"auth_token"];
    
    params[@"to_friend"] = self.friendID;
    
    //Networking code
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager GET:@"http://socialplanmaking.herokuapp.com/create_friendship/friend" parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"ResponseObject");
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Localized error: %@",[error localizedDescription]);
         }];
}


- (IBAction)friendAllBtn:(id)sender {
    NSLog(@"Friend All btn pushed");
    //[self callServerToMakeFriends: self.friends];
}


- (IBAction)DoneBtn:(id)sender {
    NSLog(@"Skip btn psuhed");
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
