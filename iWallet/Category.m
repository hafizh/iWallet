//
//  Category.m
//  iWallet
//
//  Created by lab on 2/21/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "Category.h"
#import "SpendingItem.h"


@implementation Category

@dynamic desc;
@dynamic name;
@dynamic priority;
@dynamic spending;


-(float) getSumAmountForMonth:(NSDateComponents*)month
{
    NSNumber *sum = [[self filterSpendingItems:self.spending byMonth:month] valueForKeyPath:@"@sum.price"];
    return [sum floatValue];
}

-(float) getSumAmountForYear:(NSDateComponents*)year
{
    NSNumber *sum = [[self filterSpendingItems:self.spending byYear:year] valueForKeyPath:@"@sum.price"];
    return [sum floatValue];
}


-(NSMutableSet*)filterSpendingItems:(NSSet*)spendintItems byMonth:(NSDateComponents*)monthComp
{
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSMutableSet *filteredItems = [[NSMutableSet alloc] init];
    
    for (SpendingItem *item in spendintItems) {
        NSDateComponents *itemsMonthComp = [calendar components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:item.date];
        if([itemsMonthComp month]==[monthComp month] && [itemsMonthComp year]==[monthComp year]){
            [filteredItems addObject: item];
        }
    }
    return filteredItems;
}

-(NSMutableSet*)filterSpendingItems:(NSSet*)spendintItems byDay:(NSDateComponents*)dayComp
{
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSMutableSet *filteredItems = [[NSMutableSet alloc] init];
     
    for (SpendingItem *item in spendintItems) {
        NSDateComponents *itemsDayComp = [calendar components:(NSDayCalendarUnit) fromDate:item.date];
        if([itemsDayComp day]==[dayComp day]){
            [filteredItems addObject: item];
        }
    }
    return filteredItems;
}
-(NSArray*) classifySpendingsByDateForMonth:(NSDateComponents*)month
{   NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSMutableSet *filteredSpendings = [self filterSpendingItems:self.spending byMonth:month];
    
    NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[calendar dateFromComponents:month]];
    
    NSMutableArray *classifiedSpendings = [[NSMutableArray alloc] init];

    for (int i = 0; i<= days.length; i++) {
        [classifiedSpendings addObject:[NSNumber numberWithFloat:0]];
    }
    
    for(SpendingItem *item in filteredSpendings) {
        NSDateComponents *oneDay = [calendar components:(NSDayCalendarUnit) fromDate:item.date];
        [classifiedSpendings replaceObjectAtIndex:[oneDay day] withObject:[[self filterSpendingItems:filteredSpendings byDay:oneDay] valueForKeyPath:@"@sum.price"]];
    }
    return classifiedSpendings;
}

-(NSMutableSet*)filterSpendingItems:(NSSet*)spendintItems byYear:(NSDateComponents*)yearComp
{
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSMutableSet *filteredItems = [[NSMutableSet alloc] init];
    
    for (SpendingItem *item in spendintItems) {
        NSDateComponents *itemsYearComp = [calendar components:(NSYearCalendarUnit) fromDate:item.date];
        if([itemsYearComp year]==[yearComp year]){
            [filteredItems addObject: item];
        }
    }
    
    return filteredItems;
}

-(NSArray*) classifySpendingsByMonthForYear:(NSDateComponents*)year
{   NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSMutableSet *filteredSpendings = [self filterSpendingItems:self.spending byYear:year];
    
    NSRange months = [calendar rangeOfUnit:NSMonthCalendarUnit inUnit:NSYearCalendarUnit forDate:[calendar dateFromComponents:year]];
    NSMutableArray *classifiedSpendings = [[NSMutableArray alloc] init];
    for (int i = 0; i<= months.length; i++) {
        [classifiedSpendings addObject:[NSNumber numberWithFloat:0]];
    }
    
    for(SpendingItem *item in filteredSpendings) {
        NSDateComponents *oneMonth = [calendar components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:item.date];
        [classifiedSpendings replaceObjectAtIndex:[oneMonth month] withObject:[[self filterSpendingItems:filteredSpendings byMonth:oneMonth] valueForKeyPath:@"@sum.price"]];
    }

    return classifiedSpendings;
}


@end
