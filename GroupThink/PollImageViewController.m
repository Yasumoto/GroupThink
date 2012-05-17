//
//  PollImageViewController.m
//  GroupThink
//
//  Created by Joe Smith on 5/17/12.
//  Copyright (c) 2012 GroupThink. All rights reserved.
//

#import "PollImageViewController.h"

#define MINIMUM_SCROLL_SCALE 0.5;
#define MAXIMUM_SCROLL_SCALE 2.0;

@interface PollImageViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation PollImageViewController
@synthesize scrollView;
@synthesize imageView;
@synthesize image = _image;

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
    self.scrollView.minimumZoomScale = MINIMUM_SCROLL_SCALE;
    self.scrollView.maximumZoomScale = MAXIMUM_SCROLL_SCALE;
    self.scrollView.delegate = self;
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewWillAppear:(BOOL)animated {
    self.imageView = [[UIImageView alloc] initWithImage:self.image];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.zoomScale = 1;
    self.scrollView.contentSize = self.imageView.bounds.size;
    CGFloat widthZoom = self.scrollView.bounds.size.width / self.imageView.image.size.width;
    CGFloat heightZoom = self.scrollView.bounds.size.height / self.imageView.image.size.height;
    if (widthZoom > heightZoom) {
        self.scrollView.zoomScale = widthZoom;
    }
    else {
        self.scrollView.zoomScale = heightZoom;
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [self.scrollView flashScrollIndicators];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UIScrollViewDelegate
- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
