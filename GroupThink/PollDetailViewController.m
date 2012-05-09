//
//  PollDetailViewController.m
//  GroupThink
//
//  Created by Joe Smith on 5/8/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import "PollDetailViewController.h"

@interface PollDetailViewController ()

@end

@implementation PollDetailViewController
@synthesize poll = _poll;
@synthesize QuestionTextView = _QuestionTextView;
@synthesize memberOneLabel = _memberOneLabel;
@synthesize memberTwoLabel = _memberTwoLabel;
@synthesize answers = _answers;

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
}

- (void)viewDidUnload
{
    [self setQuestionTextView:nil];
    [self setMemberOneLabel:nil];
    [self setMemberTwoLabel:nil];
    [self setAnswers:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addAnswer:(UIButton *)sender {
}
@end
