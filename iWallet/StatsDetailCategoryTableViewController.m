//
//  StatsDetailCategoryTableViewController.m
//  iWallet
//
//  Created by lab on 1/24/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "StatsDetailCategoryTableViewController.h"

@interface StatsDetailCategoryTableViewController ()

@end

@implementation StatsDetailCategoryTableViewController

NSArray *months;
//NSMutableArray *sectionsHeaders;
//NSMutableDictionary *sectionHeadersDictionary;
NSArray *spendingItems;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //*************** Init spending items for selected category *******************
    EntityController *controller = [EntityController getInstance];
    //self.selectedCategory = @"Other";
    Category *category = [[controller dataAccessLayer] getCategoryWithName:self.selectedCategory];
    DataQueries *queries = [[DataQueries alloc] init];
    spendingItems = [queries getSpendingsForCategory:category];
    
    //
    //localCategories = [[NSArray alloc] initWithArray:[[controller dataAccessLayer] get]];

    // Centralize months array in one object
//    months = [[NSArray alloc] initWithObjects:
//              @"January",
//              @"February",
//              @"March",
//              @"April",
//              @"May",
//              @"June",
//              @"July",
//              @"August",
//              @"September",
//              @"October",
//              @"November",
//              @"December", nil];
    
//    sectionHeadersDictionary = [[NSMutableDictionary alloc] init];
//    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    for (SpendingItem *item in spendingItems) {
//        NSDateComponents *monthAyear = [calendar components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:item.date];
//        
//        [sectionHeadersDictionary setValue:item forKey:[NSString stringWithFormat:@"%d",[monthAyear month]+[monthAyear year]]];
//    }
    
    self.mainTitle.title = self.selectedCategory;
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSNumber *spentAmount = [[spendingItems objectAtIndex:indexPath.row] price];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f €", [spentAmount doubleValue]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[spendingItems objectAtIndex:indexPath.row] date]];
    
    return cell;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [sectionsHeaders objectAtIndex:section];
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

//#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//    
//}

@end
