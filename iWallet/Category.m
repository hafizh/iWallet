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
    
    NSMutableArray *classifiedSpendings = [[NSMutableArray alloc] init];
    
    for(SpendingItem *item in filteredSpendings) {
        NSDateComponents *oneDay = [calendar components:(NSDayCalendarUnit) fromDate:item.date];
        [classifiedSpendings setValue:[[self filterSpendingItems:filteredSpendings byDay:oneDay] valueForKeyPath:@"@sum.price"] forKey:[NSString stringWithFormat:@"%d",[oneDay day]]];
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
    
    NSMutableArray *classifiedSpendings = [[NSMutableArray alloc] init];
    
    for(SpendingItem *item in filteredSpendings) {
        NSDateComponents *oneMonth = [calendar components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:item.date];
        [classifiedSpendings setValue:[[self filterSpendingItems:filteredSpendings byMonth:oneMonth] valueForKeyPath:@"@sum.price"] forKey:[NSString stringWithFormat:@"%d",[oneMonth month]]];
    }
    
    return classifiedSpendings;
}


@end
