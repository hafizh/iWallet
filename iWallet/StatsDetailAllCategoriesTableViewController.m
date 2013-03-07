//
//  StatsDetailAllCategoriesTableViewController.m
//  iWallet
//
//  Created by lab on 1/24/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "StatsDetailAllCategoriesTableViewController.h"
#import "StatsDetailCategoryTableViewController.h"

@interface StatsDetailAllCategoriesTableViewController (){
    NSArray *localCategories;
    NSString *currencySign;
}
@end

@implementation StatsDetailAllCategoriesTableViewController

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
    
    //*************** Init categories *******************
    EntityController *controller = [EntityController getInstance];
    localCategories = [[NSArray alloc] initWithArray:[[controller dataAccessLayer] getCategories]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    currencySign = [prefs stringForKey:@"currency"];
    
    if([prefs valueForKey:@"currency"] == nil){
        currencySign = @"€";
    }
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
    return localCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"category";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Category *cat = [localCategories objectAtIndex:indexPath.row];
    cell.textLabel.text = [cat name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f%@", [self.naviStrategy getCurrentSumAmountforCategory:cat], currencySign];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromCategoriesToCategory"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        StatsDetailCategoryTableViewController *categoryTableView = segue.destinationViewController;
        categoryTableView.selectedCategory = [[localCategories objectAtIndex:indexPath.row] name];
    }
    
}

@end
