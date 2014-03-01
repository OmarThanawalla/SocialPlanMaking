//
//  Inbox.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/22/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "Inbox.h"


@interface Inbox ()

@property (nonatomic, strong) NSArray * temp;

@end

@implementation Inbox

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
    NSLog(@"Inbox: ViewDidLoad");
    self.title = @"Inbox of Activities";
    
    
    //First time download
    [self UserDetermineCredentials];

    self.temp = @[@"Swim @ Barton Springs", @"Eat @ Trudy's Restaurant", @"Biking @ Zilker Park", @"Climbing @ Gregory", @"Boating @ Lake Travis"];
    
    
    //sample GET Request
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:@"http://socialplanmaking.herokuapp.com/" parameters:nil
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             NSLog(@"Sucesss");
//             NSLog(@"JSON: %@",responseObject);
//             NSLog(@"this is what: %@",responseObject[0][@"hi"]);
//
//         }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             NSLog(@"Fail");
//             NSLog(@"Error: %@",error);
//         }];
    

}

-(void)UserDetermineCredentials
{
    BOOL LoggedIn = YES;
    
    //1. Grab Credentials from Apple Keychain - if empty  LoggedIn = false
    //3. Else Logged in true
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * auth = [defaults objectForKey:@"auth_token"];
    NSString * user_id = [defaults objectForKey:@"user_id"];
    NSLog(@"these are you creds: %@, %@",auth, user_id);
    
    
    [defaults synchronize];

    
    if(LoggedIn)
    {
        //Show Inbox
        //Aka Do Nothing
        
    }else{
        //Show the Login view
        [self performSegueWithIdentifier:@"Registration" sender:self];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"the self.temp count is: %d",[self.temp count]);
    return [self.temp count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.temp[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)sender didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath called");
    [self performSegueWithIdentifier:@"ViewActivity" sender:self];

}

- (IBAction)refresh:(id)sender {
    NSLog(@"refresh btn");
    //Networking code
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    //get user id
    params[@"user_id"] = [defaults objectForKey:@"user_id"];
    //get auth tok
    params[@"auth_token"] = [defaults objectForKey:@"auth_token"];
    
    [manager GET:@"http://socialplanmaking.herokuapp.com/inbox_activities/retrieve" parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"ResponseObject: %@",responseObject);
             NSDictionary * JSON = responseObject[0];
             self.temp = JSON[@"activities"];
             [self.tableView reloadData];
             NSLog(@"Table reloaded");
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error");
             NSLog(@"%@", [error localizedDescription]);
         }];
}
@end
