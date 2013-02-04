//
//  FirstViewController.h
//  iWallet
//
//  Created by lab on 1/22/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

-(void) currentMonth;
-(void) moneyLeft;
@property (weak, nonatomic) IBOutlet UILabel *currentMonth;

@property (weak, nonatomic) IBOutlet UILabel *monthlyBudgetLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneySpentLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLeftLabel;
@end
