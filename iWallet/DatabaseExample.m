//
//  DatabaseExample.m
//  iWallet
//
//  Created by lab on 2/21/13.
//  Copyright (c) 2013 lab. All rights reserved.
//  This class is created, to show how the database layer can be accessed.
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
                          @"Food & Groceries",
                          @"Houshold & Rent",
                          @"Clothing",
                          @"Going Out",
                          @"Sports & Hobbies",
                          @"Study Costs",
                          @"Health Care & Cosmetics",
                          @"Transportation & Travel",
                          @"Other", nil];
        
        NSLog(@"%@", [NSDate date]);
        dates = [[NSArray alloc] initWithObjects:
                 @"2012-02-07",
                 @"2013-03-06",
                 @"2011-07-08",
                 @"2012-11-09",
                 @"2013-01-15",
                 @"2011-10-23",
                 @"2013-01-11",
                 @"2011-08-05",
                 @"2012-12-25",
                 @"2013-02-14", nil];
    }
    
    return self;
}

//add all categories of the array "categories" to the database
-(void)addCategories {
    // clear all old test categories before adding some new ones
    [self clearAllCategories];
    
    Category *cat;
    for (int i = 0; i < categories.count; i++) {
        cat = factory.createCategory;
        [cat setName:[categories objectAtIndex:i]];
        [cat setDesc:@"Das ist die Beschreibung"];
        [cat setPriority:(NSDecimalNumber*)[NSDecimalNumber numberWithInt:i]];
    }
    
    [dal saveContext];
    
    for (Category *cat in dal.getCategories) {
        NSLog(@"%@",cat.name);
        NSLog(@"%@",cat.desc);
    }
    
}

//add some randomly generated spendings
-(void)addSpendings {
 
    [self clearAllSpendings];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    for (int j=0; j<10; j++) {

    Category *cat = [dal.getCategories objectAtIndex:arc4random_uniform(9)];
 
    SpendingItem *spending;
    for (int i = 0; i < 10; i++) {
        spending = factory.createSpendingItem;
        [spending setDesc:[[NSArray arrayWithObjects: @"Spending",[NSNumber numberWithInt:i], nil]     componentsJoinedByString:@" " ]];
        [spending setDate:[dateFormatter dateFromString:[dates objectAtIndex:i]]];
        [spending setCategory:cat];
        [spending setPrice:[NSNumber numberWithFloat:arc4random_uniform(90)]];
        [spending setDesc:@"some description"];
    }
    }
     [dal saveContext];
}

//prints a query by using the DataQueries 
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

//use the getSpendingsWithFilter method of the DataAccessLayer to filter all spendings
//with a price >= 0.45. The spendings are ascending sorted by price.
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

-(void)clearAllSpendings {
    NSArray *currentSpendings = [[NSArray alloc] initWithArray:[dal getSpendingsWithFilter:nil andSortDescriptor:nil]];
    
    for (SpendingItem *si in currentSpendings) {
        [dal deleteSpending:si];
    }
    [dal saveContext];
}
@end
