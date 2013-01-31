//
//  StatsMainViewController.m
//  iWallet
//
//  Created by lab on 1/23/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "StatsMainViewController.h"
#import "StatsDetailAllCategoriesTableViewController.h"
#import "PlotView.h"

@interface StatsMainViewController ()

@end

@implementation StatsMainViewController

NSArray *categories;
NSArray *chartModes;
NSArray *months;
NSArray *years;
int currentMonthIndex = 0;
int currentYearIndex = 1;

int viewHeight = 180;
int viewWidth = 320;
int modeValue = 0; // 0 or 1, monthly or yearly respectively

// scrollview pages
PlotView *page1;
PlotView *page2;


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

//    CGRect categoriesFrame = CGRectMake(0, 0, 320, 240);
//    [self.categoriesTableView setFrame:categoriesFrame];
//    
//    CGRect chartFrame = CGRectMake(0,250, 320, 230);
//    [self.scrollView setFrame:chartFrame];
//    
//    [self.view addSubview:self.categoriesTableView];
//    [self.view addSubview:self.scrollView];
    //*************** Init DUMMY arrays *******************
    
    categories = [[NSArray alloc] initWithObjects:
                  @"Detail...",
                  @"All",
                  @"Food & Groceries",
                  @"Houshold & Rent",
                  @"Clothing",
                  @"Going Out",
                  @"Sports & Hobbies",
                  @"Study Costs",
                  @"Health Care & Cosmetics",
                  @"Transportation & Travel",
                  @"Other", nil];

    // charts text. // Later should be actual charts
    chartModes = [[NSArray alloc] initWithObjects:@"Monthly Chart", @"Yearly Chart", nil];
    
    // later will be extracted from db.
    months = [[NSArray alloc] initWithObjects:
              @"January",
              @"February",
              @"March",
              @"April",
              @"May",
              @"June",
              @"July",
              @"August",
              @"September",
              @"October",
              @"November",
              @"December", nil];
    
    years = [[NSArray alloc] initWithObjects:@"2012", @"2013", nil];
    
    //******************* DUMMY FINISH *********************
    
    // set this view controller(self) as tableview delegate and data source
    self.categoriesTableView.delegate = self;
    self.categoriesTableView.dataSource = self;

    
    // Init scroll view
    // 2 charts size: monthly & yearly
    [self.scrollView setContentSize: CGSizeMake(viewWidth*2, viewHeight)];
    
    // set self as scroll view delegate: to catch scrollViewDidScroll method
    self.scrollView.delegate = self;
    
    // view 1: monthly chart
    CGRect frame1 = CGRectMake(0, 0, viewWidth, viewHeight);
    page1 = [[PlotView alloc] initWithFrame:frame1];
    //page1.backgroundColor = [UIColor blackColor];
    [self.scrollView addSubview:page1];
    
    // view 2: yearly chart
    CGRect frame2 = CGRectMake(page1.frame.origin.x+page1.frame.size.width, page1.frame.origin.y, page1.frame.size.width, page1.frame.size.height);
    page2 = [[PlotView alloc] initWithFrame:frame2];
//    page2.backgroundColor = [UIColor blackColor];
    [self.scrollView addSubview:page2];
    
    
    // set default text for labels: these are placeholders for further implementation on feedback on which
    // category selected and which mode is it(mothly, yearly, etc.)
    //self.selectedCategoryLabel.text = @"";//@"No category selected!";
    self.modeLabel.text = @"Monthly chart";
    
    self.mainTitle.title = [months objectAtIndex:currentMonthIndex];
    
    NSLog(@" tableview height:%f and page height:%f", self.categoriesTableView.frame.size.height, self.scrollView.frame.size.height);

}

- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"categories.count:%d", categories.count);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if([scrollView.restorationIdentifier isEqualToString:@"chartScroll"]){
    
        float roundedValue = round(scrollView.contentOffset.x / viewWidth);
        self.pageControl.currentPage = roundedValue;
    
        // 1st is monthly chart, 2nd is yearly mode.
        self.modeLabel.text = [chartModes objectAtIndex:roundedValue];
    
    
        modeValue = roundedValue;
    
        // TITLE: Year mode title-> current year, month mode title-> current month
        if(modeValue == 0){
            self.mainTitle.title = [months objectAtIndex:currentMonthIndex];
        }
        else{
            self.mainTitle.title = [years objectAtIndex:currentYearIndex];
        }
    
        //NSLog(@"did scroll:%f",roundedValue);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"number of rows method");
    return categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        CellIdentifier = @"detailCell";
        
    }
    else if(indexPath.row > 0){
        CellIdentifier = @"category";
    }
//    static NSString *CellIdentifier = @"category";

     cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d%%", arc4random_uniform(90)];
    
    // set the first category cell selected and set selectedcategory label accordingly.
//    if(indexPath.row == 1){
//        cell.selected = YES;
//        self.selectedCategoryLabel.text = cell.textLabel.text;
//    }
    //NSLog(@"id:%@, rowindex:%d, cell text:%@", CellIdentifier, indexPath.row, cell.textLabel.text);

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if(indexPath.row > 0){
//        self.selectedCategoryLabel.text = [categories objectAtIndex:indexPath.row];
//
//        NSString *selection = [NSString stringWithFormat:@"%@ %@", [categories objectAtIndex:indexPath.row], @"selected"];
//    
//        NSLog(@"%@", selection);
//    
//        self.selectedCategoryLabel.text = selection;
        [page1 updateData];
        [page2 updateData];
    
    }
    //NSLog(@"row selected method, row:%d", indexPath.row);
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromMainStatsToDetail"]){
        StatsDetailAllCategoriesTableViewController *dest = segue.destinationViewController;
        dest.currentMonthIndex = currentMonthIndex;
        dest.currentYearIndex = currentYearIndex;
        NSLog(@"fromMainStatsToDetail");
    }
    
}

- (IBAction)prevTimePeriodButtonTapped:(id)sender {
    
        if(modeValue == 0){
            if(currentYearIndex>=0){
            [self decrementByMonth];
            }
        }
        else{
            if(currentYearIndex>0){
            [self decrementByYear];
            }
        }
        NSLog(@" currentMonthIndex:%d and year:%d", currentMonthIndex, currentYearIndex);
    [page1 updateData];
    [page2 updateData];
    
        //self.mainTitle.title = [months objectAtIndex:currentMonthIndex]
}


- (IBAction)nextTimePeriodButtonTapped:(id)sender {

    if(currentMonthIndex<months.count && currentYearIndex<years.count-1){
        if(modeValue == 0){
            [self incrementByMonth];
        }
        else{
            [self incrementByYear];
        }
    }
    
    NSLog(@" currentMonthIndex:%d and year:%d", currentMonthIndex, currentYearIndex);
    [page1 updateData];
    [page2 updateData];
  
    //self.mainTitle.title = [months objectAtIndex:currentMonthIndex];
}

- (void)decrementByMonth
{
    if(currentMonthIndex > 0){
        currentMonthIndex--;
    }
    else if(currentYearIndex > 0){
        currentYearIndex--;
        currentMonthIndex = months.count-1;
    }
    
    self.mainTitle.title = [months objectAtIndex:currentMonthIndex];
}

- (void)decrementByYear
{
    if(currentYearIndex >= 0){
        currentYearIndex--;
         self.mainTitle.title = [years objectAtIndex:currentYearIndex];
    }
}

- (void)incrementByMonth
{
    if(currentMonthIndex > months.count-2){
        currentMonthIndex = 0;
        
        if(currentYearIndex < 1){
            currentYearIndex++;
        }
    }
    else{
        currentMonthIndex++;
    }
    self.mainTitle.title = [months objectAtIndex:currentMonthIndex];
}

- (void)incrementByYear
{
    if(currentYearIndex<years.count-1){
        currentYearIndex++;
        self.mainTitle.title = [years objectAtIndex:currentYearIndex];
    }
}
@end
