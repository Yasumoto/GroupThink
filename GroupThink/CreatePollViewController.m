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
@synthesize memberOne;
@synthesize memberTwo;

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
    memberOne.delegate = self;
    memberTwo.delegate = self;
}

- (void)viewDidUnload
{
    [self setQuestionField:nil];
    [self setMemberOne:nil];
    [self setMemberTwo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)createPollButtonPressed:(UIButton *)sender {
    PFObject *pollObject = [PFObject objectWithClassName:@"Poll"];
    [pollObject setObject:self.questionField.text forKey:@"question"];
    [pollObject setObject:self.memberOne.text forKey:@"memberOne"];
    [pollObject setObject:self.memberTwo.text forKey:@"memberTwo"];
    [pollObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if (succeeded) {
     NSLog(@"Saved poll succeeded!");
    }
    }];
}
@end
