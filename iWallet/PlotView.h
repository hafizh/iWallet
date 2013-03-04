//
//  PlotView.h
//  iWallet
//
//  Created by lab on 1/29/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataQueries.h"
#import "DateNavigationStrategy.h"

@interface PlotView : UIView

- (void) updateDataByCategory:(Category *)cat;

@property id<DateNavigationStrategy> plotNaviStrategy;

@end
