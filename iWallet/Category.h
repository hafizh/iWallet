//
//  Categories.h
//  iWallet
//
//  Created by lab on 2/14/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SpendingItem;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * priority;
@property (nonatomic, retain) SpendingItem *spendingItem;

@end
