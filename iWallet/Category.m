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

@end
