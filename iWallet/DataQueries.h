//
//  DataQueries.h
//  iWallet
//
//  Created by lab on 2/20/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataAccessLayer.h"
@interface DataQueries : NSObject
-(NSArray*)getSpendingsFrom:(NSDate*)start Till:(NSDate*)end withSortDescriptor:(NSSortDescriptor*)descriptor;
-(NSArray*)getSpendingsInYear:(NSDateComponents*)year withSortDescriptor:(NSSortDescriptor*)descriptor;
-(NSArray*)getSpendingsForMonth:(NSDateComponents*)month withSortDescriptor:(NSSortDescriptor*)descriptor;
@end
DataAccessLayer *dal;