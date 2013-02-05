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

int tableHeightInit = 370;
int tableHeight = 190;
int viewHeight = 180;
int viewWidth = 320;
int modeValue = 0; // 0 or 1, monthly or yearly respectively

// default Landscape plot init
int lPlotViewHeight = 320;
int lPlotViewWidth = 460;

// scrollview pages
PlotView *page1;
PlotView *page2;

UIInterfaceOrientation toOrientation;
CGRect previousFrame;

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

   
    // set self as scroll view delegate: to catch scrollViewDidScroll method
    self.scrollView.delegate = self;
    
    // set default text for labels: these are placeholders for further implementation on feedback on which
    // category selected and which mode is it(mothly, yearly, etc.)
    self.modeLabel.text = @"Monthly chart";
    
    self.mainTitle.title = [months objectAtIndex:currentMonthIndex];
 
    // initialize the layout
    [self initLayout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self initLayout];
}

// INTERFACE ORIENTATION METHODS

// Overriden
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)){
        toOrientation = toInterfaceOrientation;
        [self updateLayoutToPortrait];
    }
    else if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation) && !UIInterfaceOrientationIsLandscape(toOrientation)){
        //[self performSegueWithIdentifier:@"modalLandscapePlotSegue" sender:NULL];
        toOrientation = toInterfaceOrientation;
        UIView *tempView = [self.tabBarController.view.subviews objectAtIndex:0];
        previousFrame = tempView.frame;
        [self updateLayoutToLandscape];
    }
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if(UIInterfaceOrientationIsLandscape(toOrientation) && UIInterfaceOrientationIsPortrait(fromInterfaceOrientation)){
        [[self.tabBarController.view.subviews objectAtIndex:0] setFrame:CGRectMake(0, 0, 480, 320)];
        [[self.tabBarController.view.subviews objectAtIndex:1] setHidden:TRUE];
    }
    if(UIInterfaceOrientationIsPortrait(toOrientation)){
        [[self.tabBarController.view.subviews objectAtIndex:0] setFrame:previousFrame];
        [[self.tabBarController.view.subviews objectAtIndex:1] setHidden:FALSE];
    }
}

// Custom Methods
- (void) updateLayoutToPortrait
{
    [self.navigationController setNavigationBarHidden:FALSE animated:FALSE];
    [self initLayout];
    //[self updateLayout];
}

- (void) updateLayoutToLandscape
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.height;
    CGFloat screenHeight = screenRect.size.width;
    
    [self.navigationController setNavigationBarHidden:TRUE animated:FALSE];
    //[[UIApplication sharedApplication] setStatusBarHidden:TRUE withAnimation:FALSE];
    screenHeight -= [[UIApplication sharedApplication] statusBarFrame].size.height;
    [self.scrollView setFrame:CGRectMake(0, 0, screenWidth,screenHeight)];
    // Init scroll view
    // 2 charts size: monthly & yearly
    [self.scrollView setContentSize: CGSizeMake(screenWidth*2, screenHeight)];
    
    // view 1: monthly chart
    CGRect frame1 = CGRectMake(0, 0, screenWidth, screenHeight);
    [page1 setFrame:frame1];
    
    // view 2: yearly chart
    CGRect frame2 = CGRectMake(screenWidth, 0, screenWidth, screenHeight);
    [page2 setFrame:frame2];
    
    [self.scrollView addSubview:page1];
    [self.scrollView addSubview:page2];
    
    [self.scrollView setAlpha:1.0f];
}


- (void)updateLayout
{
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [self.scrollView setAlpha:1.0f];
                         [self.categoriesTableView setFrame:CGRectMake(0, 0, viewWidth, tableHeight)];
                         self.pageControl.hidden = NO;
                         self.modeLabel.hidden = NO;
                     }
     ];
    
    [self.categoriesTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle
                                                                animated:YES];
}

- (void) initLayout
{
    self.view.frame = CGRectMake(0, 0, 320, 370);
    
    // Init scroll view
    // 2 charts size: monthly & yearly
    [self.scrollView setContentSize: CGSizeMake(viewWidth*2, viewHeight)];
    
    // view 1: monthly chart
    CGRect frame1 = CGRectMake(0, 0, viewWidth, viewHeight);
    page1 = [[PlotView alloc] initWithFrame:frame1];
    [self.scrollView addSubview:page1];
    
    // view 2: yearly chart
    CGRect frame2 = CGRectMake(page1.frame.origin.x+page1.frame.size.width, page1.frame.origin.y, page1.frame.size.width, page1.frame.size.height);
    page2 = [[PlotView alloc] initWithFrame:frame2];
    [self.scrollView addSubview:page2];
    

    [UIView animateWithDuration:0.5f
                     animations:^{
                         [self.scrollView setAlpha:0.0f];
                         self.modeLabel.hidden = YES;
                         self.pageControl.hidden = YES;
                     }
     ];
    
    [self.categoriesTableView deselectRowAtIndexPath:[self.categoriesTableView indexPathForSelectedRow] animated:NO];
    self.categoriesTableView.frame = CGRectMake(0, 0, viewWidth, tableHeightInit);
    self.scrollView.frame = CGRectMake(0, tableHeight, viewWidth, viewHeight);
}

// LandscapePlotViewController delegate method || Currently not used.
- (void)LandscapePlotViewDismissedOnInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:orientation duration:duration];
}
// END Interface orientation methods

// SCROLLVIEW CONTROLLER DELEGATE METHODs
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if([scrollView.restorationIdentifier isEqualToString:@"chartScroll"]){
    
        float roundedValue = round(scrollView.contentOffset.x / viewWidth);
        self.pageControl.currentPage = roundedValue;
    
        // 1st is monthly chart, 2nd is yearly mode.
        if(roundedValue<2){
            self.modeLabel.text = [chartModes objectAtIndex:roundedValue];
        }
        
        modeValue = roundedValue;
    
        // TITLE: Year mode title-> current year, month mode title-> current month
        if(modeValue == 0){
            self.mainTitle.title = [months objectAtIndex:currentMonthIndex];
        }
        else{
            self.mainTitle.title = [years objectAtIndex:currentYearIndex];
        }
    
    }
}
// END scrollview Delegate


// TABLEVIEW CONTROLLER DELEGATE METHODs
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
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

     cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d%%", arc4random_uniform(90)];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row > 0){
        [self updateLayout];
        [page1 updateData];
        [page2 updateData];
    }
}
// END tableview Delegate

// DETAIL Categories
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromMainStatsToDetail"]){
        StatsDetailAllCategoriesTableViewController *dest = segue.destinationViewController;
        dest.currentMonthIndex = currentMonthIndex;
        dest.currentYearIndex = currentYearIndex;
    }
    
}


// Navigate by month or year next and prev buttons
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
    [page1 updateData];
    [page2 updateData];
    
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