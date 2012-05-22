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

#define LOGGED_IN_SEGUE @"loggedInSegue"

#pragma mark PFLogInViewControllerDelegate

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    if (user) {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"User %@ has been logged in, performing segue.", user);
            [PFPush subscribeToChannelInBackground:[[PFUser currentUser] username]];
            [self performSegueWithIdentifier:LOGGED_IN_SEGUE sender:self];
        }];
    }
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark PFSignUpViewControllerDelegate

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self updatePollACLs];
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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated {
    if ([PFUser currentUser].username) {
        NSLog(@"Logged in user is: %@", [PFUser currentUser].username);
        // TODO(Yasumoto): remove the below line
        [self updatePollACLs];
        [self performSegueWithIdentifier:LOGGED_IN_SEGUE sender:self];
    } else {
        PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
        logInController.delegate = self;
        logInController.signUpController.delegate = self;
        logInController.fields = PFLogInFieldsUsernameAndPassword
        | PFLogInFieldsLogInButton
        | PFLogInFieldsSignUpButton
        | PFLogInFieldsPasswordForgotten
        | PFLogInFieldsDismissButton
        | PFLogInFieldsFacebook;
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
    if ([segue.identifier isEqualToString:LOGGED_IN_SEGUE]) {
        NSLog(@"%@", @"Preparing to segue to main view");
    }
}

#pragma mark Update Poll Sharing

- (void) updatePollACLs {
    NSString *emailAddress = [[PFUser currentUser] email];
    PFQuery *sharingQuery = [PFQuery queryWithClassName:@"Polls"];
    [sharingQuery whereKey:@"members" equalTo:emailAddress];
    NSLog(@"Checking for previously shared polls with %@", emailAddress);
    [sharingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@", objects);
    }];

}

@end
