//
//  CreatePollViewController.m
//  GroupThink
//
//  Created by Joe Smith on 5/8/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import "CreatePollViewController.h"

@interface CreatePollViewController ()

@end

@implementation CreatePollViewController
@synthesize questionField;
@synthesize members;

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
    questionField.delegate = self;
    members.delegate = self;
}

- (void)viewDidUnload
{
    [self setQuestionField:nil];
    [self setMembers:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) addWriteAccessOnPoll:(PFObject *)pollObject ForEmailAddress:(NSString *)emailAddress {
    PFQuery *query = [PFQuery queryForUser];
    [query whereKey:@"email" equalTo:emailAddress];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error && objects.count > 0) {
            PFUser *user = [objects objectAtIndex:0];
            if (user) {
                PFACL *pollACL = [pollObject ACL];
                [pollACL setReadAccess:YES forUser:user];
                [pollObject setACL:pollACL];
                [pollObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"The poll has been saved!");
                    }
                }];
            }
        }
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)createPollButtonPressed:(UIButton *)sender {
    PFObject *pollObject = [PFObject objectWithClassName:@"Poll"];
    [pollObject setObject:self.questionField.text forKey:@"question"];
    [pollObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Saved poll succeeded!");
        }
    }];
}
@end
