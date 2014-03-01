//
//  InboxIndepth.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/22/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "InboxIndepth.h"
#import "ActivityInformationCell.h"
#import "WhenIsGoodCell.h"

@interface InboxIndepth ()

@end

@implementation InboxIndepth

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

    self.title = @"Activity";
    
    //[self loadInboxIndepthData];
    [self refresh:nil];
}

-(void) loadInboxIndepthData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *parameters = @{@"user_id": [defaults objectForKey:@"user_id"],
                                 @"auth_token": [defaults objectForKey: @"auth_token"],
                                 @"fb_token" : [defaults objectForKey:@"accessToken"],
                                 @"event_id" : [defaults objectForKey:@"currentEventID"]
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://socialplanmaking.herokuapp.com/read_event/event" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Success");
         NSLog(@"Response: %@",responseObject);
         
         self.responseObjectJSON = responseObject;
         [self.tableView reloadData];
         //Load up the View

         //[self performSegueWithIdentifier:@"ShowFriends" sender:nil];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Fail");
         NSLog(@"Error: %@",[error localizedDescription]);
         //alert box
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
    NSDictionary * dict = self.responseObjectJSON[2];
    int friends = [dict[@"friends"] count];
    return 3 + friends;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0)
    {
        static NSString *CellIdentifier = @"Info";
        ActivityInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        //wire up data
        NSLog(@"dict %@",self.responseObjectJSON[0]);
        
        cell.initiator.text = self.responseObjectJSON[0][@"initiator"];
        NSMutableDictionary * activities = self.responseObjectJSON[1];
        NSMutableArray * arrayOfActivities = activities[@"activities"];
        
        
        if([arrayOfActivities count] > 2)
        {
            NSMutableDictionary * thirdAct =  arrayOfActivities[2];
            cell.Activity3.text = thirdAct[@"activity"];
            cell.vote3.text =  [NSString stringWithFormat:@"%@", thirdAct[@"vote"]];
        }
        if ([arrayOfActivities count] > 1)
        {
            NSMutableDictionary * secondAct =  arrayOfActivities[1];
            cell.Activity2.text = secondAct[@"activity"];
            cell.vote2.text =  [NSString stringWithFormat:@"%@", secondAct[@"vote"]];
        }
        if([arrayOfActivities count] > 0)
        {
            
            NSMutableDictionary * firstAct =  arrayOfActivities[0];
            cell.Activity1.text = firstAct[@"activity"];
            cell.vote1.text =  [NSString stringWithFormat:@"%@", firstAct[@"vote"]];
        }
        
        
        return cell;
        
    }
    else if (indexPath.row == 1)
    {
        static NSString *CellIdentifier = @"Calendar";
        WhenIsGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(indexPath.row == 2)
    {
        
        static NSString *CellIdentifier = @"Friends";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        cell.textLabel.text = @"Friends going";
        
        return cell;
    }
    else{
        NSDictionary * dict = self.responseObjectJSON[2];
        NSMutableArray *friendsList = dict[@"friends"];
        
    static NSString *CellIdentifier = @"Friends";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    cell.textLabel.text = friendsList[indexPath.row-3];
        
    return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 227;
    }
    else{
        return 56;
    }
}


- (IBAction)refresh:(id)sender {
    [self loadInboxIndepthData];
}
@end
