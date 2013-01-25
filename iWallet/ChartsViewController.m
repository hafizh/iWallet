//
//  ChartsViewController.m
//  iWallet
//
//  Created by lab on 1/22/13.
//
//

#import "ChartsViewController.h"

@interface ChartsViewController ()

@end

@implementation ChartsViewController


//int viewHeight = 275;
//int viewWidth = 320;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    float roundedValue = round(scrollView.contentOffset.x / viewWidth);
//    self.pageControl.currentPage = roundedValue;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
  
//    [self.scrollView setContentSize: CGSizeMake(viewWidth*2, viewHeight)];
//    self.scrollView.delegate = self;
//    
//    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
//    UIView *page1 = [[UIView alloc] initWithFrame:frame];
//    page1.backgroundColor = [UIColor grayColor];
//    [self.scrollView addSubview:page1];
//    
//    NSLog(@"view height:%@",[NSString stringWithFormat:@"%f", self.view.bounds.size.height]);
//    frame = CGRectMake(page1.frame.origin.x+page1.frame.size.width, page1.frame.origin.y, page1.frame.size.width, page1.frame.size.height);
//    UIView *page2 = [[UIView alloc] initWithFrame:frame];
//    page2.backgroundColor = [UIColor blackColor];
//    [self.scrollView addSubview:page2];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
