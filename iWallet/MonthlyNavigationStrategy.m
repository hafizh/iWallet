//
//  MonthlyNavigationStrategy.m
//  iWallet
//
//  Created by lab on 2/25/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "MonthlyNavigationStrategy.h"

@implementation MonthlyNavigationStrategy

NSCalendar *calendar;

/// firstDate <= prevDate <= currentDate >= nextDate >= lastDate
NSDate *firstDate;
NSDate *prevDate;
NSDate *currentDate;
NSDate *nextDate;
NSDate *lastDate;

NSDateComponents *currentComp;
NSArray *allSpendingItems;

NSArray *months;

-(id)init
{
    [self superclass];
    if(self != nil){
     // do some init work here
        
        months = [[NSArray alloc] initWithObjects:
                  @"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];

        // get All spendings
        DataQueries *queries = [[DataQueries alloc] init];
        allSpendingItems = [[NSArray alloc] initWithArray:[queries getSpendings]];

        firstDate = [allSpendingItems valueForKeyPath:@"@min.date"];
        
        
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        lastDate = [NSDate date];
        currentComp = [calendar components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:lastDate];
        //NSLog(@"currentComp month:%d, year:%d", [currentComp month], [currentComp year]);
        currentDate = lastDate;
        
        // calculate next and prev dates to check
        NSDateComponents *aMonth = [[NSDateComponents alloc] init];
        
        [aMonth setMonth:1];
        nextDate = [calendar dateByAddingComponents:aMonth toDate:currentDate options:0];

        [aMonth setMonth:-1];
        prevDate = [calendar dateByAddingComponents:aMonth toDate:currentDate options:0];
        
        NSLog(@"prev: %@, currendD:%@, nextDate:%@", prevDate, currentDate,nextDate);
    }
    return self;
}

-(NSDateComponents*)getNext
{
    if([self checkNext]){
        NSDateComponents *oneMonth = [[NSDateComponents alloc] init];
        
        [oneMonth setMonth:1];
        
        prevDate = currentDate;
        currentDate = nextDate;
        
        // calculate nextDate for checking
        nextDate = [calendar dateByAddingComponents:oneMonth toDate:nextDate options:0];
        currentComp = [calendar components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:currentDate];
    }

    return currentComp;
}

- (NSString *)getNextTitle
{
    NSDateComponents *nextComp = [calendar components:(NSMonthCalendarUnit) fromDate:nextDate];
    return [months objectAtIndex:[nextComp month]-1];
}

-(NSDateComponents*)getCurrent
{
    return currentComp;
}

-(NSString *)getCurrentTitle
{
    return [NSString stringWithFormat:@"%@/%d",[months objectAtIndex:[currentComp month]-1], [currentComp year]];
}
-(NSDateComponents*)getPrevious
{
    if([self checkPrevious]){
        NSDateComponents *oneMonth = [[NSDateComponents alloc] init];

        nextDate = currentDate;
        currentDate = prevDate;
        
        [oneMonth setMonth:-1];
        prevDate = [calendar dateByAddingComponents:oneMonth toDate:prevDate options:0];
        currentComp = [calendar components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:currentDate];
    }
    
    return currentComp;
}

-(NSString *)getPreviousTitle
{
    NSDateComponents *prevComp = [calendar components:(NSMonthCalendarUnit) fromDate:prevDate];
    return [months objectAtIndex:[prevComp month]-1];
}

-(BOOL) checkNext
{
    return ([lastDate compare:nextDate] == NSOrderedDescending) || ([lastDate compare:nextDate] == NSOrderedSame);
}

-(BOOL) checkPrevious
{
    return ([firstDate compare:prevDate] == NSOrderedAscending)|| ([firstDate compare:prevDate] == NSOrderedSame);
}

@end
