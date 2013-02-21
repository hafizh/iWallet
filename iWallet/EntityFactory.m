//
//  Factory.m
//  Test
//
//  Created by lab on 1/31/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "EntityFactory.h"
#import "CoreData/NSEntityDescription.h"
#import "CoreData/NSManagedObjectContext.h"

@interface EntityFactory (PrivateMethod)
-(NSObject*)createEntity: (NSString*) entity;
@end


@implementation EntityFactory
@synthesize context;
- (id)initWithContext:(NSManagedObjectContext*)c
{
    self = [super init];
    if (self) {
        [self setContext:c];
    }
    return self;
}

-(NSObject*)createEntity: (NSString*)entity {

    NSObject *o = [NSEntityDescription
                  insertNewObjectForEntityForName:entity
                             inManagedObjectContext:context];
    return o;
}

-(Category*)createCategory {
   return (Category*)[self createEntity:@"Categories"];
}

-(SpendingItem*)createSpendings {
    return (SpendingItem*)[self createEntity:@"Spendings"];
}

@end
