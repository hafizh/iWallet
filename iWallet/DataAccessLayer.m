//
//  DAL.m
//  Test
//
//  Created by lab on 1/31/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "DataAccessLayer.h"
#import "Category.h"

@implementation DataAccessLayer
@synthesize managedObjectContext;
-(id)initWithContext: (NSManagedObjectContext*)context{
    self = [super init];
    
    if (self) {
        [self setManagedObjectContext:context];
    }
    
    return self;
}


-(void)deleteCategory: (NSString*) name  {
    Category *category;
    
    for (Category *cat in [self getCategories]) {
        if ([cat.name isEqualToString:name])
            category = cat;
    }
    
    if (category != nil) {
        [[self managedObjectContext]  deleteObject:category];
    } else {
        //error handling
        NSLog(@"Category doesn't exist");
    }
}

-(NSArray*)getCategories  {
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Category" inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    NSArray *fetchedObjects = [[self managedObjectContext]
                               executeFetchRequest:request error:&error];
    
    return fetchedObjects;
}


-(void)deleteSpending: (SpendingItem*) spending {
    
    [[self managedObjectContext]  deleteObject:spending];
    
}

-(NSArray*)getSpendingsWithFilter:(NSPredicate*)predicate andSortDescriptor: (NSSortDescriptor*)descriptor {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"SpendingItem"
                inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    
    if (predicate != nil)
        [request setPredicate:predicate];
    
    if (descriptor != nil)
        [request setSortDescriptors:@[descriptor]];
    
    NSError *error;
    NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
    if (array != nil) {
        
    }
    else {
        // error handling
        
    }
    
    return array;
    
}


-(void)saveContext {
    NSError *error;
    if (![[self managedObjectContext] save:&error]) {
        // NSLog([error localizedDescription]);
    }
}

@end
