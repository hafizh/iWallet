//
//  DAL.h
//  Test
//
//  Created by lab on 1/31/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityController.h"
//TODO: Architecture
@protocol DataAccessLayer <NSObject>

-(void)deleteCategory: NSString: name;
-(NSArray*)getCategories;


-(void)deleteSpending: Spendings: spending;
-(NSArray*)getSpendingsInMonth:NSDate:date;
-(NSArray*)getSpendingInMonth:(NSDate*)date withDescription:(NSString*)desc andPrice:(double)price;
@end

@protocol EnitityControllerDelegate <NSObject>
@optional
- (NSManagedObjectContext *) managedObjectContext;
-(void)saveContext;
@end

@interface DataAccessLayer : NSObject <DataAccessLayer,EnitityControllerDelegate>
{
    id <EnitityControllerDelegate> delegate;
}
@property (retain) id delegate;
@end
