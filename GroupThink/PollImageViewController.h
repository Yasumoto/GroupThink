//
//  PollImageViewController.h
//  GroupThink
//
//  Created by Joe Smith on 5/17/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PollImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@end
