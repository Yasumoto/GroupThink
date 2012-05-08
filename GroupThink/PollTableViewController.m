//
//  PollTableViewController.m
//  GroupThink
//
//  Created by Joe Smith on 5/5/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import "PollTableViewController.h"

@interface PollTableViewController ()

@end

@implementation PollTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // This table displays a user's polls
        self.className = @"PollList";
        self.keyToDisplay = @"Title";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    NSLog(@"The className of the PFTableView is: %@", self.className);
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithClassName:@"Foo"];
    self = [super initWithCoder:aDecoder];
    if (self) {        
        // The className to query on
        self.className = @"PollList";
        
        // The key of the PFObject to display in the label of the default cell style
        self.keyToDisplay = @"Title";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    NSLog(@"The className of the PFTableView (when initWithCoder) is: %@", self.className);
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}*/

#pragma mark UITableViewDataSource

/*- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
                         object:(PFObject *)object {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Poll List Cells"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Poll List Cells"];
    }
    cell.textLabel.text = [[PFUser currentUser] username];
    cell.detailTextLabel.text = @"Is a baoss";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}*/

@end
