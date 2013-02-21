//
//  Factory.h
//  Test
//
//  Created by lab on 1/31/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData/NSManagedObjectContext.h"
#import "Category.h"
#import "SpendingItem.h"
@interface EntityFactory : NSObject
@property (nonatomic, retain) NSManagedObjectContext* context;
- (id)initWithContext:(NSManagedObjectContext*)c;
-(Category*)createCategory;
-(SpendingItem*)createSpendingItem;
@end
