//
//  DAL.h
//  Test
//
//  Created by lab on 1/21/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Factory.h"

#import "DataAccessLayer.h"

@interface EntityController : NSObject
{
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    Factory *factory;

}

@property (retain) id delegate;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain, readonly) Factory *factory;

@end