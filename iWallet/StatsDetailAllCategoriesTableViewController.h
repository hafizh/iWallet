//
//  StatsDetailAllCategoriesTableViewController.h
//  iWallet
//
//  Created by lab on 1/24/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityController.h"
#import "DateNavigationStrategy.h"

@interface StatsDetailAllCategoriesTableViewController : UITableViewController

// Later can extract from db according to actual dates
@property int currentMonthIndex;
@property int currentYearIndex;
@property id<DateNavigationStrategy> naviStrategy;

@end
