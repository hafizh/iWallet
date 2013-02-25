//
//  Category.h
//  iWallet
//
//  Created by lab on 2/21/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SpendingItem;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * priority;
@property (nonatomic, retain) NSSet *spending;

-(float) getSumAmountForMonth:(NSDateComponents*)month ;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)addSpendingObject:(SpendingItem *)value;
- (void)removeSpendingObject:(SpendingItem *)value;
- (void)addSpending:(NSSet *)values;
- (void)removeSpending:(NSSet *)values;

@end
