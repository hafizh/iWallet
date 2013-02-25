//
//  DateNavigationStrategy.h
//  iWallet
//
//  Created by lab on 2/25/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DateNavigationStrategy

-(NSDate*) getNext;
-(NSDate*) getPrevious;
-(BOOL) checkNext;
-(BOOL) checkPrevious;

@end
