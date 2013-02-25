//
//  DatabaseExample.h
//  iWallet
//
//  Created by lab on 2/21/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataAccessLayer.h"
#import "EntityFactory.h"
@interface DatabaseExample : NSObject {
    DataAccessLayer *dal;
    EntityFactory *factory;
    NSArray *categories;
}

-(void)addCategories;
-(void)addSpendings;

@end
