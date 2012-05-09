//
//  CreatePollViewController.h
//  GroupThink
//
//  Created by Joe Smith on 5/8/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CreatePollViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *questionText;
@property (weak, nonatomic) IBOutlet UITextField *memberOne;
@property (weak, nonatomic) IBOutlet UITextField *memberTwo;
- (IBAction)createPollButtonPressed:(UIButton *)sender;

@end
