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

#pragma mark UITableViewDataSource

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
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
}

@end
