//
//  EntityController.h
//  
//
//  Created by lab on 1/21/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityFactory.h"
#import "DataAccessLayer.h"

@interface EntityController : NSObject
{
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    EntityFactory *factory;
    DataAccessLayer *dataAccessLayer;
    
}

@property (retain) id delegate;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain, readonly) EntityFactory *factory;
@property (nonatomic, retain, readonly) DataAccessLayer *dataAccessLayer;
+ (EntityController *)getInstance;
@end