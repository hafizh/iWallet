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
//    float sum = 0;
    NSNumber *sum = [self.spending valueForKeyPath:@"@sum.price"];
    return [sum floatValue];
}
@end
