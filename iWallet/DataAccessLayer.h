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
-(NSArray*)getSpendingsWithFilter:(NSPredicate*)predicate andSortDescriptor: (NSSortDescriptor*)descriptor;

-(void)saveContext;
@end

@interface DataAccessLayer : NSObject <DataAccessLayer>

-(id)initWithContext: (NSManagedObjectContext*)context;

@property (retain) NSManagedObjectContext* managedObjectContext;

@end
