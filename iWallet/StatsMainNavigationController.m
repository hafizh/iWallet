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

@end
