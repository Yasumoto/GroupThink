//
//  SettingsViewController.h
//  GroupThink
//
//  Created by Joe Smith on 5/16/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SettingsViewController : UIViewController
@property (nonatomic, strong) NSString *emailAddress;
@property (weak, nonatomic) IBOutlet UILabel *name;
- (IBAction)signOut:(id)sender;

@end
