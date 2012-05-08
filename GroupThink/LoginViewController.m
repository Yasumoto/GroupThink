//
//  ViewController.m
//  GroupThink
//
//  Created by Joe Smith on 5/5/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property BOOL login;
@end

@implementation LoginViewController

@synthesize login = _login;

#define POLL_LIST_SEGUE @"pollListView"

#pragma mark PFLogInViewControllerDelegate

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    NSLog(@"%@", user);
    if (user) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self performSegueWithIdentifier:POLL_LIST_SEGUE sender:self];
        }];
    }
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark PFSignUpViewControllerDelegate

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)signUpViewControllerDidCancelLogIn:(PFSignUpViewController *)signUpController {
    [self dismissModalViewControllerAnimated:YES];
}



/*- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)signUpViewControllerDidCancelLogIn:(PFSignUpViewController *)signUpController {
    [self dismissModalViewControllerAnimated:YES];
}*/

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.login = NO;
	// Do any additional setup after loading the view, typically from a nib.
     /*PFObject *testObject = [PFObject objectWithClassName:@"PollList"];
    [testObject setObject:@"dan" forKey:@"Title"];
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Saved object succeeded!");
        }
    }];*/
}

- (void) viewDidAppear:(BOOL)animated {
    if ([PFUser currentUser]) {
        [self performSegueWithIdentifier:POLL_LIST_SEGUE sender:self];
    } else {
        PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
        logInController.delegate = self;
        logInController.signUpController.delegate = self;
        [self presentViewController:logInController animated:YES completion:NULL];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pollListView"]) {
        NSLog(@"%@", @"Preparing to segue to pollList");
    }
}

@end
