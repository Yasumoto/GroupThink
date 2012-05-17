//
//  PollDetailViewController.h
//  GroupThink
//
//  Created by Joe Smith on 5/8/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PollDetailViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) PFObject *poll;
@property (weak, nonatomic) IBOutlet UILabel *QuestionTextView;
@property (weak, nonatomic) IBOutlet UILabel *members;
@property (weak, nonatomic) IBOutlet UITextView *answers;
- (IBAction)addAnswer:(UIButton *)sender;
- (IBAction)refresh:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *answer;

@end
