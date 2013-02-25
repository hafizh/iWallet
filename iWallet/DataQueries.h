//
//  DataQueries.h
//  iWallet
//
//  Created by lab on 2/20/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataAccessLayer.h"
@interface DataQueries : NSObject {
   DataAccessLayer *dal; 
}
-(NSArray*)getSpendingsForCategory:(Category *)cat from:(NSDate*)start Till:(NSDate*)end withSortDescriptor:(NSSortDescriptor*)descriptor;
-(NSArray*)getSpendingsForCategory:(Category *)cat inYear:(NSDateComponents*)year withSortDescriptor:(NSSortDescriptor*)descriptor;
-(NSArray*)getSpendingsForCategory:(Category *)cat forMonth:(NSDateComponents*)month withSortDescriptor:(NSSortDescriptor*)descriptor;
-(NSArray*)getSpendingsForMonth:(NSDateComponents*)month withSortDescriptor:(NSSortDescriptor*)descriptor;
-(NSArray*)getSpendings;
-(NSArray*)getSpendingsForCategory:(Category*)cat;
@end
