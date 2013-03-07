//
//  DataQueries.m
//  iWallet
//
//  Created by lab on 2/20/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "DataQueries.h"
#import "EntityController.h"
#import "DataAccessLayer.h"
#import "EntityFactory.h"
#import "Category.h"
#import "SpendingItem.h"

@implementation DataQueries

-(id)init {
    self = [super init];
    
    if (self) {
        EntityController *entityController = [EntityController getInstance];

        dal = [entityController dataAccessLayer];
    }
    
    return self;
}


-(NSArray*)getSpendingsForCategory:(Category *)cat from:(NSDate*)start Till:(NSDate*)end withSortDescriptor:(NSSortDescriptor*)descriptor {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@ AND (date >= %@ AND date <= %@)",cat, start, end];
    
    return [dal getSpendingsWithFilter:predicate andSortDescriptor:descriptor];
    
}

-(NSArray*)getSpendingsForCategory:(Category *)cat inYear:(NSDateComponents*)year withSortDescriptor:(NSSortDescriptor*)descriptor{
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    [year setDay:1];
    [year setMonth:1];
    
    NSDate *start = [calendar dateFromComponents:year];
    
    [year setDay:31];
    [year setMonth:12];
    
    NSDate *end =[calendar dateFromComponents:year];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@ AND (date >= %@ AND date <= %@)",cat, start, end];
    
    return [dal getSpendingsWithFilter:predicate andSortDescriptor:descriptor];
}

-(NSArray*)getSpendingsForCategory:(Category *)cat forMonth:(NSDateComponents*)month withSortDescriptor:(NSSortDescriptor*)descriptor {
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [month setDay:1];
    
    
    NSDate *start = [calendar dateFromComponents:month];
    [month setMonth:[month month]+1];
    NSDate *end =[[calendar dateFromComponents:month] dateByAddingTimeInterval:-86400];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@ AND (date >= %@ AND date <= %@)",cat, start, end];
    
    return [dal getSpendingsWithFilter:predicate andSortDescriptor:descriptor];
}

-(NSArray*)getSpendingsForMonth:(NSDateComponents*)month withSortDescriptor:(NSSortDescriptor*)descriptor {
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [month setDay:1];
    
    
    NSDate *start = [calendar dateFromComponents:month];
    [month setMonth:[month month]+1];
    NSDate *end =[[calendar dateFromComponents:month] dateByAddingTimeInterval:-86400];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date >= %@ AND date <= %@", start, end];
    
    return [dal getSpendingsWithFilter:predicate andSortDescriptor:descriptor];
}

-(NSArray*)getSpendings
{
    return [dal getSpendingsWithFilter:nil andSortDescriptor:nil];
}

-(NSArray*)getSpendingsForCategory:(Category*)cat
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", cat];

    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];

    return [dal getSpendingsWithFilter:predicate andSortDescriptor:sortDesc];
}

@end
