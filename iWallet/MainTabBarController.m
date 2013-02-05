//
//  MainTabBarController.m
//  iWallet
//
//  Created by lab on 2/4/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

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

- (NSUInteger)supportedInterfaceOrientations
{
    if([[self.selectedViewController restorationIdentifier] isEqualToString:@"MainNavi"]){
        return [self.selectedViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

@end
