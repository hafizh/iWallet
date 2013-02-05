//
//  LandscapePlotViewController.h
//  iWallet
//
//  Created by lab on 2/5/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LandscapePlotViewControllerDelegate <NSObject>

- (void)LandscapePlotViewDismissedOnInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration;

@end

@interface LandscapePlotViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong) id<LandscapePlotViewControllerDelegate> delegate;
@end
