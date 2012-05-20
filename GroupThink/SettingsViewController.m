//
//  SettingsViewController.m
//  GroupThink
//
//  Created by Joe Smith on 5/16/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize emailAddress = _emailAddress;
@synthesize name = _name;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.name.text = [NSString stringWithFormat:@"Hope you're enjoying Gather, %@!", [[PFUser currentUser] username]];
}

- (void)viewDidUnload
{
    [self setName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)signOut:(id)sender {
    self.emailAddress = [[PFUser currentUser] email];
    NSLog(@"Logging out %@", self.emailAddress);
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logItOut" sender:self];
}
@end
