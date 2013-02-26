//
//  DateNavigationStrategy.h
//  iWallet
//
//  Created by lab on 2/25/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DateNavigationStrategy
/**
 Navigation protocol to navigate by month or by year depending on classes that comply to this protocol.
 */

-(NSDateComponents*) getNext;
-(NSString*) getNextTitle;
-(NSDateComponents*) getPrevious;
-(NSString*)getPreviousTitle;
-(NSDateComponents*) getCurrent;
-(NSString*)getCurrentTitle;
-(BOOL) checkNext;
-(BOOL) checkPrevious;

@end
