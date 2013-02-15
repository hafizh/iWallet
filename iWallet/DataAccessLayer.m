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
@synthesize delegate;
-(id)init {
   self = [super init];
   
    return self;
}


-(void)deleteCategory: NSString: name  {
    Categories *category;
    for (Categories *cat in [self getCategories]) {
        if ([cat.name isEqualToString:name])
            category = cat;
    }
    
    [[[self delegate] managedObjectContext] deleteObject:category];
}

-(NSArray*)getCategories  {
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categories" inManagedObjectContext:[[self delegate] managedObjectContext]];
    [request setEntity:entity];
    NSArray *fetchedObjects = [[[self delegate] managedObjectContext]
                                    executeFetchRequest:request error:&error];

    return fetchedObjects;
}


-(void)deleteSpending: Spendings: spending {
    
}

-(NSArray*)getSpendingsInMonth:NSDate:date {
    return nil;
}
-(NSArray *)getSpendingInMonth:(NSDate *)date withDescription:(NSString *)desc andPrice:(double)price {
    return nil;
}

@end
