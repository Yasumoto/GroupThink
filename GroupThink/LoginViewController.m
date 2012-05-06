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

#pragma mark PFLogInViewControllerDelegate

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    NSLog(@"%@", user);
    if (user) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self performSegueWithIdentifier:@"pollListView" sender:self];
        }];
    }
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
    /*
     PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"dan" forKey:@"greg"];
    [testObject save];
     */
}

- (void) viewDidAppear:(BOOL)animated {
    if (self.login == NO) {
        PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
        logInController.delegate = self;
        [self presentViewController:logInController animated:YES completion:NULL];
        self.login = YES;
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

@end
