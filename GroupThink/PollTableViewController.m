//
//  PollTableViewController.m
//  GroupThink
//
//  Created by Joe Smith on 5/5/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import "PollTableViewController.h"
#import "PollDetailViewController.h"

@interface PollTableViewController ()

@end

@implementation PollTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // This table displays a user's polls
        self.className = @"Poll";
        self.keyToDisplay = @"question";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    NSLog(@"The className of the PFTableView is: %@", self.className);
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"viewPoll"]) {
        if ([segue.destinationViewController isKindOfClass:[PollDetailViewController class]]) {
            PollDetailViewController *pollController = segue.destinationViewController;
            int indexOfPoll = [self.tableView indexPathForCell:sender].row;
            pollController.poll = [self.objects objectAtIndex:indexOfPoll];
        }
    }
}

#pragma mark PFQueryTableViewController

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
                         object:(PFObject *)object {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Poll List Cells"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"Poll List Cells"];
    }
    cell.textLabel.text = [object objectForKey:@"question"];
    cell.detailTextLabel.text = [object objectForKey:@"owner"];
    return cell;
}

@end
