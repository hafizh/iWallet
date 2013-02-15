//
//  StatsMainNavigationController.m
//  iWallet
//
//  Created by lab on 2/4/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "StatsMainNavigationController.h"

@interface StatsMainNavigationController ()

@end

@implementation StatsMainNavigationController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSUInteger) supportedInterfaceOrientations
{       
    return [self.visibleViewController supportedInterfaceOrientations];
}


- (BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}

//- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)){
//        [self supportedInterfaceOrientations];
//        [self shouldAutorotate];
//        //[self dismissed:toInterfaceOrientation duration:duration];
//        [self dismissViewControllerAnimated:YES completion:NULL];
//    }
//    else if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){
//        [self.visibleViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    }
//}

//- (void) updateLayoutToLandscape
//{
//    // Do some crazy stuff to display the Plot in Full screen.
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
//    LandscapePlotViewController *landscapePlotViewController = [storyboard instantiateViewControllerWithIdentifier:@"LandscapePlotViewController"];
//    
//    //[landscapePlotViewController setDelegate:self];
//    [self presentViewController:landscapePlotViewController animated:YES completion:NULL];
//}


@end
