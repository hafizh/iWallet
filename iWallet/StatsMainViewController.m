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

@interface StatsMainViewController (){

    NSArray *categories;
    NSArray *chartModes;
    NSArray *monthsFull;
    NSArray *years;
    
    // view size => default values
    int viewHeight;
    int viewWidth;
    int tableHeight;
    int scrollHeight;
    CGFloat currentScrollViewAlpha;
    
    int modeValue; // 0 or 1, monthly or yearly respectively
    CGFloat animationDuration;
    
    // scrollview pages
    PlotView *page1;
    PlotView *page2;
    
    id<DateNavigationStrategy> naviStrategy;
    DataQueries *dbLayer;
    
    // used in didRotate... method
    UIInterfaceOrientation toOrientation;
    
    CGRect previousFrame;
    
    // Navigation strategies
    YearlyNavigationStrategy *yearlyNaviStrategy;
    MonthlyNavigationStrategy *monthlyNaviStrategy;
    
    NSIndexPath *selectedIndexPath;
    float budget;
    
}

@end

@implementation StatsMainViewController


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

    viewHeight = 370;
    viewWidth = 320;
    tableHeight = 190;
    scrollHeight = 180;
    currentScrollViewAlpha = 0.0f;
    
    modeValue = 0; // 0 or 1, monthly or yearly respectively
    animationDuration = 0.3f;

    // Init navi strategies
    yearlyNaviStrategy = [[YearlyNavigationStrategy alloc] init];
    monthlyNaviStrategy = [[MonthlyNavigationStrategy alloc] init];
    
    // in default, strategy is set to monthly
    naviStrategy = monthlyNaviStrategy;
    [self.nextButton setEnabled:[naviStrategy checkNext]];
    [self.prevButton setEnabled:[naviStrategy checkPrevious]];
    self.mainTitle.title = [naviStrategy getCurrentTitle];
    self.nextButton.title = [naviStrategy getNextTitle];
    self.prevButton.title = [naviStrategy getPreviousTitle];

    //******************* DATA INIT *********************
    dbLayer = [[DataQueries alloc] init];
    EntityController *controller = [EntityController getInstance];
    
    // add categories first time.
    DatabaseExample *dbEx = [[DatabaseExample alloc] init];
    if([[controller dataAccessLayer] getCategories].count<=0){
        [dbEx addCategories];
        categories = [[NSArray alloc] initWithArray:[[controller dataAccessLayer] getCategories]];
    }else{
        categories = [[NSArray alloc] initWithArray:[[controller dataAccessLayer] getCategories]];
    }
    if([[controller dataAccessLayer] getSpendingsWithFilter:nil andSortDescriptor:nil].count <= 0){
        [dbEx addSpendings];
    }
    
    // charts text.
    chartModes = [[NSArray alloc] initWithObjects:@"Monthly Chart", @"Yearly Chart", nil];
    
    // Months titles to map to date's month integer value
    monthsFull = [[NSArray alloc] initWithObjects:
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
    
    //******************* DATA INIT FINISH *********************
    
    // set this view controller(self) as tableview delegate and data source
    self.categoriesTableView.delegate = self;
    self.categoriesTableView.dataSource = self;

   
    // set self as scroll view delegate: to catch scrollViewDidScroll method
    self.scrollView.delegate = self;
    
    // set default text for labels: these are placeholders for further implementation on feedback on which
    // category selected and which mode is it(mothly, yearly, etc.)
    self.modeLabel.text = @"Monthly chart";
    
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

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    budget = [prefs floatForKey:@"Monthly budget"];
    [self.categoriesTableView reloadData];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self initLayout];
    selectedIndexPath = [self.categoriesTableView indexPathForSelectedRow];
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
        if(self.pageControl.currentPage == 1){
            [self.scrollView scrollRectToVisible:CGRectMake(480, tableHeight, 480, 300) animated:NO];
        }
    }
    if(UIInterfaceOrientationIsPortrait(toOrientation)){
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             [[self.tabBarController.view.subviews objectAtIndex:0] setFrame:previousFrame];[[self.tabBarController.view.subviews objectAtIndex:1] setHidden:FALSE];
                                                [self updateLayoutToPortrait];
                         }
         ];
    }
    [self.modeLabel setAdjustsFontSizeToFitWidth:YES];
    [self.modeLabel setFrame:CGRectMake(self.view.frame.origin.x, self.scrollView.frame.origin.y+5, self.view.frame.size.width, 30)];
}

// Custom Methods
- (void) updateLayoutToPortrait
{
    [self.navigationController setNavigationBarHidden:FALSE animated:FALSE];
    [self.categoriesTableView setAlpha:1.0f];

    if(currentScrollViewAlpha >= 0){
        [self resizeScrollViewToHeight:scrollHeight width:viewWidth origin:CGPointMake(0, tableHeight)];
    }
    
    if(selectedIndexPath.row > 0 && selectedIndexPath.row < 10){
        [page1 updateDataByCategory:[categories objectAtIndex:selectedIndexPath.row - 1]];
        [page2 updateDataByCategory:[categories objectAtIndex:selectedIndexPath.row - 1]];
    }
    
}

- (void) updateLayoutToLandscape
{
    
    [self.scrollView setAlpha:currentScrollViewAlpha];
    [self.categoriesTableView setAlpha:currentScrollViewAlpha];
    
    // hide navigation bar, but leave status bar
    [self.navigationController setNavigationBarHidden:TRUE animated:FALSE];
    [self resizeScrollViewToHeight:300 width:480 origin:CGPointMake(0, 0)];

    if(selectedIndexPath.row > 0 && selectedIndexPath.row < 10){
        [page1 updateDataByCategory:[categories objectAtIndex:selectedIndexPath.row - 1]];
        [page2 updateDataByCategory:[categories objectAtIndex:selectedIndexPath.row - 1]];
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
    [page1 setPlotNaviStrategy:monthlyNaviStrategy];
    [self.scrollView addSubview:page1];
    
    // view 2: yearly chart
    CGRect frame2 = CGRectMake(frame1.origin.x + width, frame1.origin.y, width, height);
    page2 = [[PlotView alloc] initWithFrame:frame2];
    [page2 setPlotNaviStrategy:yearlyNaviStrategy];
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
            naviStrategy = monthlyNaviStrategy;
        }
        else{
            naviStrategy = yearlyNaviStrategy;
        }
        
        // set titles according to navi strategy
        self.mainTitle.title = [naviStrategy getCurrentTitle];
        self.nextButton.title = [naviStrategy getNextTitle];
        self.prevButton.title = [naviStrategy getPreviousTitle];
        self.nextButton.enabled = [naviStrategy checkNext];
        self.prevButton.enabled = [naviStrategy checkPrevious];

        // reload data for year or month and restore selection
        [self.categoriesTableView reloadData];
        if(selectedIndexPath.row != 0){
            [self.categoriesTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];

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
    return categories.count+1; // +1 for Overview... cell
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        CellIdentifier = @"detailCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = @"Overview...";
    }
    else if(indexPath.row > 0){
        CellIdentifier = @"category";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
        // Configure the cell...
        Category *cat = [categories objectAtIndex:indexPath.row - 1]; // -1 because of Overview... cell
        cell.textLabel.text = cat.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f %%", [naviStrategy getCurrentSumAmountforCategory:cat]*100/budget];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row > 0){
        [self updateLayoutCategorySelected];
        
        [page1 updateDataByCategory:[categories objectAtIndex:indexPath.row - 1]]; // -1 because of Overview... cell
        
        [page2 updateDataByCategory:[categories objectAtIndex:indexPath.row - 1]]; // -1 because of Overview... cell
        
        selectedIndexPath = [self.categoriesTableView indexPathForSelectedRow];
    }
}
// END tableview Delegate

// DETAIL Categories
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromMainStatsToDetail"]){
        StatsDetailAllCategoriesTableViewController *dest = segue.destinationViewController;
        dest.naviStrategy = naviStrategy;
    }
}


// Navigate by month or year next and prev buttons
- (IBAction)prevTimePeriodButtonTapped:(id)sender {

    // TODO: Used to query db according to month or year
    [naviStrategy calculatePrevious];
    self.mainTitle.title = [naviStrategy getCurrentTitle];
    self.nextButton.title = [naviStrategy getNextTitle];
    self.prevButton.title = [naviStrategy getPreviousTitle];
    
    [self.prevButton setEnabled:[naviStrategy checkPrevious]];
    [self.nextButton setEnabled:[naviStrategy checkNext]];
    
    // reload tableview data to new month or year and restore selection(if was selected)
    [self.categoriesTableView reloadData];
    if(selectedIndexPath.row != 0){
        [self.categoriesTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }

    if(selectedIndexPath.row >0 && selectedIndexPath.row < 11){
        [page1 updateDataByCategory:[categories objectAtIndex:selectedIndexPath.row - 1]];// -1 because of Overview... cell
        [page2 updateDataByCategory:[categories objectAtIndex:selectedIndexPath.row - 1]];
    }
}

- (IBAction)nextTimePeriodButtonTapped:(id)sender {

    // TODO: Used to query db according to month or year
    [naviStrategy calculateNext];
    self.mainTitle.title = [naviStrategy getCurrentTitle];
    self.nextButton.title = [naviStrategy getNextTitle];
    self.prevButton.title = [naviStrategy getPreviousTitle];

   
    [self.nextButton setEnabled:[naviStrategy checkNext]];
    [self.prevButton setEnabled:[naviStrategy checkPrevious]];
    
    // reload tableview data to new month or year and restore selection(if was selected)
    [self.categoriesTableView reloadData];
    if(selectedIndexPath.row != 0){
        [self.categoriesTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
    
    if(selectedIndexPath.row >0 && selectedIndexPath.row < 11){
        [page1 updateDataByCategory:[categories objectAtIndex:selectedIndexPath.row - 1]];// -1 because of Overview... cell
        [page2 updateDataByCategory:[categories objectAtIndex:selectedIndexPath.row - 1]];
    }
}
@end