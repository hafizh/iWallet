//
//  DatabaseExample.m
//  iWallet
//
//  Created by lab on 2/21/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "DatabaseExample.h"
#import "EntityController.h"
@implementation DatabaseExample
-(id)init {
    self = [super init];
    
    if (self) {
       
         
        
        EntityController *entityController = [EntityController getInstance];
         DataAccessLayer *dal = [entityController dataAccessLayer];
         
         NSMutableArray *a ;
        
      /*  // Categories *cat;
        /* for (int i = 0; i < 10; i++) {
         cat = factory.createCategory;
         [cat setName:[[NSArray arrayWithObjects: @"Test ",[NSNumber numberWithInt:i], nil] componentsJoinedByString:@" " ]];
         [cat setDesc:@"Das ist die Beschreibung"];
         [a addObject:cat];
         
         }
         cat = [dal.getCategories objectAtIndex:2];
         Spendings *spending;
         for (int i = 0; i < 20; i++) {
         spending = factory.createSpending;
         [spending setDesc:[[NSArray arrayWithObjects: @"Spending",[NSNumber numberWithInt:i], nil]     componentsJoinedByString:@" " ]];
         [spending setDate:[NSDate new]];
         [spending setCategory:cat];
         [spending setPrice:[NSNumber numberWithFloat:(float)rand() / RAND_MAX]];
         [a addObject:spending];
         
         }
         
         [dal saveContext];
         
         for (Categories *cat in dal.getCategories) {
         NSLog(@"%@",cat.name);
         NSLog(@"%@",cat.desc);
         }
         
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"price >= 0.45", cat];
         
         for (Spendings *spending in [dal getSpendingsWithFilter:predicate andSortDescriptor:nil]) {
         NSLog(@"%@",[spending.price stringValue]);
         NSLog(@"%@",spending.desc);
         if (spending.category != nil)
         NSLog(@"%@",spending.category.name);
         }
         
         
        DataQueries *q = [DataQueries new];
        NSDateComponents *y = [[NSDateComponents alloc] init];
        [y setMonth:1];
        [y setYear:2013];
        for (Spendings *spending in [q getSpendingsForMonth:y withSortDescriptor:nil]) {
            NSLog(@"%@",[spending.price stringValue]);
            NSLog(@"%@",spending.desc);
            if (spending.category != nil)
                NSLog(@"%@",spending.category.name);
        }*/

    }
    
    return self;
}
@end
