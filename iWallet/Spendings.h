//
//  Spendings.h
//  iWallet
//
//  Created by lab on 2/14/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categories;

@interface Spendings : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) Categories *item;

@end
