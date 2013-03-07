//
//  StatsDetailCategoryTableViewController.m
//  iWallet
//
//  Created by lab on 1/24/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "StatsDetailCategoryTableViewController.h"

@interface StatsDetailCategoryTableViewController () {

    // internal variables
    NSArray *months;
    NSArray *spendingItems;
    NSString *currencySign;
}

@end

@implementation StatsDetailCategoryTableViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //*************** Init spending items for selected category *******************
    EntityController *controller = [EntityController getInstance];
    //self.selectedCategory = @"Other";
    Category *category = [[controller dataAccessLayer] getCategoryWithName:self.selectedCategory];
    DataQueries *queries = [[DataQueries alloc] init];
    spendingItems = [queries getSpendingsForCategory:category];
    self.mainTitle.title = self.selectedCategory;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    currencySign = [prefs stringForKey:@"currency"];
    
    if([prefs valueForKey:@"currency"] == nil){
        currencySign = @"€";
    }
    
}

// difference in months
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSMonthCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference month];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return spendingItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"item";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSNumber *spentAmount = [[spendingItems objectAtIndex:indexPath.row] price];
    cell.detailLabel.text = [NSString stringWithFormat:@"%.1f %@", [spentAmount doubleValue], currencySign];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[[spendingItems objectAtIndex:indexPath.row] date]]];
    cell.descriptionLabel.text = @"some description";
    return cell;
}


@end
