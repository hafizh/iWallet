//
//  Factory.h
//  Test
//
//  Created by lab on 1/31/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData/NSManagedObjectContext.h"
#import "Categories.h"
#import "Spendings.h"
@interface Factory : NSObject
@property (nonatomic, retain) NSManagedObjectContext* context;
- (id)initWithContext:(NSManagedObjectContext*)c;
-(Categories*)createCategory;
-(Spendings*)createSpendings;
@end
