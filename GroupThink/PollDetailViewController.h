//
//  PollDetailViewController.h
//  GroupThink
//
//  Created by Joe Smith on 5/8/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PollDetailViewController : UIViewController
@property (strong, nonatomic) PFObject *poll;
@end
