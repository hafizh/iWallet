//
//  Categories.h
//  iWallet
//
//  Created by lab on 2/14/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Spendings;

@interface Categories : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * priority;
@property (nonatomic, retain) Spendings *item;

@end
