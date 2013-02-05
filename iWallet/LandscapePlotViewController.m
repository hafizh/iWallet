//
//  LandscapePlotViewController.m
//  iWallet
//
//  Created by lab on 2/5/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "LandscapePlotViewController.h"
#import "PlotView.h"

@interface LandscapePlotViewController ()

@end

@implementation LandscapePlotViewController

// default init
int plotViewHeight = 320;
int plotViewWidth = 460;
PlotView *monthlyPlot;
PlotView *yearlyPlot;

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
    
    // init with bounds, full screen
    plotViewHeight = self.view.bounds.size.width;
    plotViewWidth = self.view.bounds.size.height;
    
    // Init scroll view
    // 2 charts size: monthly & yearly
    [self.scrollView setContentSize: CGSizeMake(plotViewWidth*2, plotViewHeight)];
    
    // set self as scroll view delegate: to catch scrollViewDidScroll method
    self.scrollView.delegate = self;
    
    // view 1: monthly chart
    CGRect frame1 = CGRectMake(0, 0, plotViewWidth, plotViewHeight);
    monthlyPlot = [[PlotView alloc] initWithFrame:frame1];
    [self.scrollView addSubview:monthlyPlot];
    
    // view 2: yearly chart
    CGRect frame2 = CGRectMake(monthlyPlot.frame.origin.x+monthlyPlot.frame.size.width, monthlyPlot.frame.origin.y, monthlyPlot.frame.size.width, monthlyPlot.frame.size.height);
    yearlyPlot = [[PlotView alloc] initWithFrame:frame2];
    [self.scrollView addSubview:yearlyPlot];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate
{
    return YES;
}
- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)){
        //[self dismissed:toInterfaceOrientation duration:duration];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (void) dismissed:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration
{
    if (self.delegate != nil) {
		if ([self.delegate respondsToSelector:@selector(LandscapePlotViewDismissedOnInterfaceOrientation:duration:)])
		{
			[self.delegate LandscapePlotViewDismissedOnInterfaceOrientation:orientation duration:duration];
		}
		else
		{
			NSLog(@"WARNING: the LandscapePlotViewController delegate does not implement LandscapePlotViewDismissedOnInterfaceOrientation:duration:");
		}
	}
	else
	{
		NSLog(@"WARNING: the LandscapePlotViewController delegate is nil");
	}
}
@end
