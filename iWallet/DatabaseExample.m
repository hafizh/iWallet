//
//  DatabaseExample.m
//  iWallet
//
//  Created by lab on 2/21/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "DatabaseExample.h"
#import "EntityController.h"
#import "DataQueries.h"
#import "Category.h"
#import "SpendingItem.h"

@implementation DatabaseExample
-(id)init {
    self = [super init];
    
    if (self) {
            
        EntityController *entityController = [EntityController getInstance];
        dal = [entityController dataAccessLayer];
        factory = [entityController factory];
        
        /*
         [self addCategories];
         [self addSpendings];
         [self priceFilterAndSort];
         [self printQuery];
        */
            categories = [[NSArray alloc] initWithObjects:
                          @"All",
                          @"Food & Groceries",
                          @"Houshold & Rent",
                          @"Clothing",
                          @"Going Out",
                          @"Sports & Hobbies",
                          @"Study Costs",
                          @"Health Care & Cosmetics",
                          @"Transportation & Travel",
                          @"Other", nil];

        
    }
    
    return self;
}

-(void)addCategories {
    // clear all old test categories before adding some new ones
    [self clearAllCategories];
    
    Category *cat;
    for (int i = 0; i < categories.count; i++) {
        cat = factory.createCategory;
        [cat setName:[categories objectAtIndex:i]];
        [cat setDesc:@"Das ist die Beschreibung"];
    }
    
    [dal saveContext];
    
    for (Category *cat in dal.getCategories) {
        NSLog(@"%@",cat.name);
        NSLog(@"%@",cat.desc);
    }
    
}

-(void)addSpendings {
    Category *cat = [dal.getCategories objectAtIndex:2];
    SpendingItem *spending;
    for (int i = 0; i < 20; i++) {
        spending = factory.createSpendingItem;
        [spending setDesc:[[NSArray arrayWithObjects: @"Spending",[NSNumber numberWithInt:i], nil]     componentsJoinedByString:@" " ]];
        [spending setDate:[NSDate new]];
        [spending setCategory:cat];
        [spending setPrice:[NSNumber numberWithFloat:(float)rand() / RAND_MAX]];
        
        
    }
}

-(void)printQuery {
   
    DataQueries *q = [DataQueries new];
    NSDateComponents *y = [[NSDateComponents alloc] init];
    [y setMonth:1];
    [y setYear:2013];
    for (SpendingItem *spending in [q getSpendingsForMonth:y withSortDescriptor:nil]) {
        NSLog(@"%@",[spending.price stringValue]);
        NSLog(@"%@",spending.desc);
        if (spending.category != nil)
            NSLog(@"%@",spending.category.name);
    }
    
}

-(void)priceFilterAndSort {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"price >= 0.45"];
    NSSortDescriptor *sortByPrice = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
    for (SpendingItem *spending in [dal getSpendingsWithFilter:predicate andSortDescriptor:sortByPrice]) {
        NSLog(@"%@",[spending.price stringValue]);
        NSLog(@"%@",spending.desc);
        if (spending.category != nil)
            NSLog(@"%@",spending.category.name);
    }
}

-(void)clearAllCategories {
    NSArray *currentCategories = [[NSArray alloc] initWithArray:[dal getCategories]];
    
    for(Category *cat in currentCategories){
        [dal deleteCategory:cat.name];
    }
    [dal saveContext];
}
@end
