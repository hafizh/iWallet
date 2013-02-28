//
//  StatsDetailCategoryTableViewController.h
//  iWallet
//
//  Created by lab on 1/24/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityController.h"
#import "DataQueries.h"

@interface StatsDetailCategoryTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *mainTitle;
@property NSString *selectedCategory;
@end
