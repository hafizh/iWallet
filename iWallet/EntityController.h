//
//  DAL.h
//  Test
//
//  Created by lab on 1/21/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityFactory.h"

#import "DataAccessLayer.h"

@interface EntityController : NSObject
{
    id <DataAccessLayer> delegate;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    EntityFactory *factory;

}

@property (retain) id delegate;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain, readonly) EntityFactory *factory;

@end