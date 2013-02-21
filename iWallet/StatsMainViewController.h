//
//  StatsMainViewController.h
//  iWallet
//
//  Created by lab on 1/23/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessLayer.h"

@interface StatsMainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (weak, nonatomic) IBOutlet UILabel *selectedCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *modeLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *mainTitle;

- (IBAction)prevTimePeriodButtonTapped:(id)sender;
- (IBAction)nextTimePeriodButtonTapped:(id)sender;
@end
