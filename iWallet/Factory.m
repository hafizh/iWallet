//
//  Factory.m
//  Test
//
//  Created by lab on 1/31/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "Factory.h"
#import "CoreData/NSEntityDescription.h"
#import "CoreData/NSManagedObjectContext.h"

@interface Factory (PrivateMethod)
-(NSObject*)createEntity: (NSString*) entity;
@end


@implementation Factory
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

-(Categories*)createCategory {
   return (Categories*)[self createEntity:@"Categories"];
}

-(Spendings*)createSpendings {
    return (Spendings*)[self createEntity:@"Spendings"];
}

@end
