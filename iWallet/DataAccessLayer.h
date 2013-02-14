//
//  DAL.h
//  Test
//
//  Created by lab on 1/31/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DataAccessLayer <NSObject>
-(void)addCategory: Category: cat;
-(void)deleteCategory: NSString: name;
-(NSArray*)getCategories;

-(void)addSpending: Spendings: spending;
-(void)deleteSpending: Spendings: spending;
-(NSArray*)getSpendingsInMonth:NSDate:date;

@end

@interface DataAccessLayer : NSObject <DataAccessLayer>

@end
