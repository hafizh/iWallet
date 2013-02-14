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

-(id)init {
   self = [super init];
   
    
    
}


-(void)addCategory: Category: cat {
    
    
    
    
    
    NSLog(@"Category %@",[cat name]);
    
    
}

-(void)deleteCategory: NSString: name  {
    
}

-(NSArray*)getCategories  {
    return nil;
}

-(void)addSpending: Spendings: spending {
    
}

-(void)deleteSpending: Spendings: spending {
    
}

-(NSArray*)getSpendingsInMonth:NSDate:date {
    return nil;
}


@end
