//
//  DAL.m
//  Test
//
//  Created by lab on 1/31/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "DataAccessLayer.h"
#import "Categories.h"

@implementation DataAccessLayer
@synthesize managedObjectContext;
-(id)initWithContext: (NSManagedObjectContext*)context{
   self = [super init];
    
    if (self) {
        [self setManagedObjectContext:context];
    }
    
   return self;
}


-(void)deleteCategory: NSString: name  {
    Categories *category;
    for (Categories *cat in [self getCategories]) {
        if ([cat.name isEqualToString:name])
            category = cat;
    }
    
    [[self managedObjectContext]  deleteObject:category];
}

-(NSArray*)getCategories  {
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categories" inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    NSArray *fetchedObjects = [[self managedObjectContext]
                                    executeFetchRequest:request error:&error];

    return fetchedObjects;
}


-(void)deleteSpending: Spendings: spending {
    
        [[self managedObjectContext]  deleteObject:spending];
    
}

-(NSArray*)getSpendingsWithFilter:(NSPredicate*)predicate andSortDescriptor: (NSSortDescriptor*)descriptor {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"Spendings"
                inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    
    [request setPredicate:predicate];
    
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
