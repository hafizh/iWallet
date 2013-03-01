//
//  YearlyNavigationStrategy.m
//  iWallet
//
//  Created by lab on 2/25/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "YearlyNavigationStrategy.h"

@implementation YearlyNavigationStrategy

NSCalendar *calendar;

/// firstDate <= prevDate <= currentDate >= nextDate >= lastDate
NSDateComponents *firstDateComp;
NSDateComponents *lastDateComp;

int prev, next, current;
NSDateComponents *currentComp;
NSArray *allSpendingItems;

-(id)init
{
    [self superclass];
    if(self != nil){
        // get All spendings
        DataQueries *queries = [[DataQueries alloc] init];
        allSpendingItems = [[NSArray alloc] initWithArray:[queries getSpendings]];
        NSDate *firstDate = [allSpendingItems valueForKeyPath:@"@min.date"];
        
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        firstDateComp = [calendar components:(NSYearCalendarUnit) fromDate:firstDate];
        NSDate *lastDate = [NSDate date];
        lastDateComp = [calendar components:(NSYearCalendarUnit) fromDate:lastDate];
        currentComp = [calendar components:(NSYearCalendarUnit) fromDate:lastDate];
        current = [lastDateComp year];

        // calculate next and prev dates to check
        next = current + 1;
        prev = current - 1;
        

    }
    return self;
}

-(NSDateComponents*)calculateNext
{
    if([self checkNext]){
        prev = current;
        current = next;
        [currentComp setYear:current];
        
        next += 1;
    }
    
    return currentComp;
}

-(NSString *)getNextTitle
{
    return [NSString stringWithFormat:@"%d", next];
}

-(NSDateComponents*)getCurrent
{
    return currentComp;
}

-(NSString *)getCurrentTitle
{
    return [NSString stringWithFormat:@"%d", [currentComp year]];
}

-(float) getCurrentSumAmountforCategory:(Category*)cat
{
    return [cat getSumAmountForYear:currentComp];
}

-(NSArray*) classifyCurrentForCategory:(Category*)cat
{
    return [cat classifySpendingsByMonthForYear:currentComp];
}

-(NSDateComponents*)calculatePrevious
{
    if([self checkPrevious]){
        next = current;
        current = prev;
        [currentComp setYear:current];
        
        prev -= 1;
    }
    
    return currentComp;
}

-(NSString *)getPreviousTitle
{
    return [NSString stringWithFormat:@"%d", prev];
}

-(BOOL) checkNext
{
    return next <= [lastDateComp year];
}

-(BOOL) checkPrevious
{
    return prev >= [firstDateComp year];
}

@end
