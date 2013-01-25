//
//  ChartsViewController.h
//  iWallet
//
//  Created by lab on 1/22/13.
//
//

#import <UIKit/UIKit.h>

@interface ChartsViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
