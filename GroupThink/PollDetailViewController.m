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
@synthesize answer = _answer;
@synthesize imageButton = _imageButton;
@synthesize poll = _poll;
@synthesize QuestionTextView = _QuestionTextView;
@synthesize members = _members;
@synthesize answers = _answers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [self updateView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.answer.delegate = self;
}

- (void)viewDidUnload
{
    [self setQuestionTextView:nil];
    [self setMembers:nil];
    [self setAnswers:nil];
    [self setAnswer:nil];
    [self setImageButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) updateView {
    self.QuestionTextView.text = [self.poll objectForKey:@"question"];
    NSString *memberList = @"";
    for (NSString *memberName in [self.poll objectForKey:@"members"]) {
        memberList = [memberList stringByAppendingFormat:@"%@\n", memberName];
    }
    self.members.text = memberList;
    self.answers.text = [self.poll objectForKey:@"answers"];
    self.navigationItem.title = [self.poll objectForKey:@"owner"];
    PFFile *imageData = [self.poll objectForKey:@"image"];
    if (![imageData isKindOfClass:[NSNull class]]) {
        [imageData getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            UIImage *image = [UIImage imageWithData:data];
            [self.imageButton setImage:image forState:UIControlStateNormal];
        }];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addAnswer:(UIButton *)sender {
    NSString *answer = [self.answers.text stringByAppendingString:@"\n"];
    answer = [answer stringByAppendingString:self.answer.text];
    answer = [answer stringByAppendingFormat:@" - %@", [PFUser currentUser].username];
    [self.poll setObject:answer forKey:@"answers"];
    [self.poll saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self updateView];
        }
    }];
}

- (IBAction)refresh:(UIBarButtonItem *)sender {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    [self.poll refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        self.poll = object;
        self.navigationItem.rightBarButtonItem = sender;
        [self updateView];
    }];
}

#pragma mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
