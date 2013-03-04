//
//  DateNavigationStrategy.h
//  iWallet
//
//  Created by lab on 2/25/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"

@protocol DateNavigationStrategy
/**
 Navigation protocol to navigate by month or by year depending on classes that comply to this protocol.
 */

-(NSDateComponents*) calculateNext;
-(NSString*) getNextTitle;
-(NSDateComponents*) calculatePrevious;
-(NSString*)getPreviousTitle;
-(NSDateComponents*) getCurrent;
-(NSString*)getCurrentTitle;
-(float) getCurrentSumAmountforCategory:(Category*)cat;
-(NSArray*) classifyCurrentForCategory:(Category*)cat;
-(BOOL) checkNext;
-(BOOL) checkPrevious;

-(NSString*) getNaviType;

/**
 * KNOWN Probable ISSUES:
 * 1. Current variable should be synchronized between navigation strategies.
 *      When on month navigation year is 2012 it should be 2012 in Year navigation too.
 */
@end
