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

// view size => default values
int viewHeight = 370;
int viewWidth = 320;
int tableHeight = 190;
int scrollHeight = 180;
CGFloat currentScrollViewAlpha = 0.0f;

int modeValue = 0; // 0 or 1, monthly or yearly respectively
CGFloat animationDuration = 0.3f;
// scrollview pages
PlotView *page1;
PlotView *page2;

DataQueries *dbLayer;

// used in didRotate... method
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

    dbLayer = [[DataQueries alloc] init];
    //[dbLayer ]
    
    EntityController *controller = [EntityController getInstance];

    if([[controller dataAccessLayer] getCategories].count<=0){
        DatabaseExample *dbEx = [[DatabaseExample alloc] init];
        [dbEx addCategories];
        categories = [[NSArray alloc] initWithArray:[[controller dataAccessLayer] getCategories]];
    }else{
        categories = [[NSArray alloc] initWithArray:[[controller dataAccessLayer] getCategories]];
    }

    // charts text.
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
 
    // init sizes
    [self initSizes];
    
    // initialize the layout
    [self initLayout];
    
    [self initScrollViewWithHeigth:scrollHeight width:viewWidth];
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
    }
    else if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation) && !UIInterfaceOrientationIsLandscape(toOrientation)){
        toOrientation = toInterfaceOrientation;
        UIView *tempView = [self.tabBarController.view.subviews objectAtIndex:0];
        previousFrame = tempView.frame;
        
    }
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if(UIInterfaceOrientationIsLandscape(toOrientation) && UIInterfaceOrientationIsPortrait(fromInterfaceOrientation)){
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             [[self.tabBarController.view.subviews objectAtIndex:0] setFrame:CGRectMake(0, 0, 480, 320)];
                             [[self.tabBarController.view.subviews objectAtIndex:1] setHidden:TRUE];
                             [self updateLayoutToLandscape];

                         }
         ];

    }
    if(UIInterfaceOrientationIsPortrait(toOrientation)){
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             [[self.tabBarController.view.subviews objectAtIndex:0] setFrame:previousFrame];[[self.tabBarController.view.subviews objectAtIndex:1] setHidden:FALSE];
                                                [self updateLayoutToPortrait];
                         }
         ];
    }
}

// Custom Methods
- (void) updateLayoutToPortrait
{
    [self.navigationController setNavigationBarHidden:FALSE animated:FALSE];
    [self.categoriesTableView setAlpha:1.0f];

    if(currentScrollViewAlpha >= 0){
        
//        [UIView animateWithDuration:animationDuration
//                         animations:^{
                             [self resizeScrollViewToHeight:scrollHeight width:viewWidth origin:CGPointMake(0, tableHeight)];
//                         }
//         ];
    }
    
}

- (void) updateLayoutToLandscape
{
    
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenHeight = screenRect.size.height;
//    CGFloat screenWidth = screenRect.size.width;
//    screenHeight -= [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    [self.scrollView setAlpha:currentScrollViewAlpha];
    [self.categoriesTableView setAlpha:currentScrollViewAlpha];
    
    // hide navigation bar, but leave status bar
    [self.navigationController setNavigationBarHidden:TRUE animated:FALSE];
    [self resizeScrollViewToHeight:300 width:480 origin:CGPointMake(0, 0)];
    
    if(self.pageControl.currentPage == 1){
        [self.scrollView scrollRectToVisible:CGRectMake(480, tableHeight, 480, 300) animated:NO];
    }
}


- (void)updateLayoutCategorySelected
{   currentScrollViewAlpha = 1.0f;
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         [self.scrollView setAlpha:currentScrollViewAlpha];
                         [self.categoriesTableView setFrame:CGRectMake(0, 0, viewWidth, tableHeight)];
                         [self resizeScrollViewToHeight:scrollHeight width:viewWidth origin:CGPointMake(0, tableHeight)];
                         self.pageControl.hidden = NO;
                         self.modeLabel.hidden = NO;
                     }
     ];
    
    [self.categoriesTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle
                                                                animated:YES];
}

- (void) initLayout
{
    self.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    currentScrollViewAlpha = 0.0f;
    [self.scrollView setAlpha:currentScrollViewAlpha];
    // Hide scroll view animated
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.modeLabel.hidden = YES;
                         self.pageControl.hidden = YES;
                     }
     ];
    
    [self.categoriesTableView deselectRowAtIndexPath:[self.categoriesTableView indexPathForSelectedRow] animated:NO];
    self.categoriesTableView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
}

// Chart view(scrollView paging enabled) methods: init and resize
- (void) initScrollViewWithHeigth:(CGFloat)height width:(CGFloat)width
{
    // Init scroll view
    self.scrollView.frame = CGRectMake(0, tableHeight, width, height);
    
    // 2 charts size: monthly & yearly
    [self.scrollView setContentSize: CGSizeMake(width*2, height)];
    
    // view 1: monthly chart
    CGRect frame1 = CGRectMake(0, 0, width, height);
    page1 = [[PlotView alloc] initWithFrame:frame1];
    [self.scrollView addSubview:page1];
    
    // view 2: yearly chart
    CGRect frame2 = CGRectMake(frame1.origin.x + width, frame1.origin.y, width, height);
    page2 = [[PlotView alloc] initWithFrame:frame2];
    [self.scrollView addSubview:page2];
}

- (void) resizeScrollViewToHeight:(CGFloat)height width:(CGFloat)width origin:(CGPoint)origin
{
    [self.scrollView setFrame:CGRectMake(origin.x, origin.y, width, height)];
    // Init scroll view
    // 2 charts size: monthly & yearly
    [self.scrollView setContentSize: CGSizeMake(width*2, height)];
    
    // view 1: monthly chart
    CGRect frame1 = CGRectMake(0, 0, width, height);
    [page1 setFrame:frame1];
    
    // view 2: yearly chart
    CGRect frame2 = CGRectMake(width, 0, width, height);
    [page2 setFrame:frame2];
}

- (void) initSizes
{
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat naviBarHeight = [self.navigationController navigationBar].frame.size.height;
    CGFloat tabBarHeight = [[self.tabBarController.view.subviews objectAtIndex:1] frame].size.height;
    
    viewHeight = [[UIScreen mainScreen] bounds].size.height - (statusBarHeight + naviBarHeight + tabBarHeight) + 2;
    viewWidth = [[UIScreen mainScreen] bounds].size.width + 2;

    tableHeight = viewHeight*0.5135 + 1;
    scrollHeight = viewHeight - tableHeight;

}

// END Interface orientation methods

// SCROLLVIEW CONTROLLER DELEGATE METHODs
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if([scrollView.restorationIdentifier isEqualToString:@"chartScroll"]){
    
        float roundedValue = round(scrollView.contentOffset.x / page1.frame.size.width);
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
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = @"Detail...";
    }
    else if(indexPath.row > 0){
        CellIdentifier = @"category";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
        // Configure the cell...
        Category *cat = [categories objectAtIndex:indexPath.row];
        cell.textLabel.text = cat.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lf%%", [cat getSumAmountForMonth:nil]/10];

    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row > 0){
        [self updateLayoutCategorySelected];
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
}


// TODO: More OO Way of doing this. Use Strategy or State design pattern(Maybe kind of
// an iterator object which can iterate by year or month)
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