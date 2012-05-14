//
//  CreatePollViewController.h
//  GroupThink
//
//  Created by Joe Smith on 5/8/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ButtonPeoplePicker.h"

@interface CreatePollViewController : UIViewController <UITextFieldDelegate, ButtonPeoplePickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *questionField;
@property (weak, nonatomic) IBOutlet UILabel *namesLabel;
- (IBAction) createPollButtonPressed:(UIButton *)sender;
@end
