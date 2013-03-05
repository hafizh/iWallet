//
//  FirstViewController.h
//  iWallet
//
//  Created by lab on 1/22/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverviewViewController : UIViewController

-(void) currentMonth;
-(void) moneyLeft;
-(void) changeStatus:(NSString *)information;

- (IBAction)setDollar:(id)sender;
- (IBAction)setEuro:(id)sender;
- (IBAction)setPound:(id)sender;

- (void)saveCurrencyToNSUserDefaults:(NSString*) currency;

- (IBAction)setBudget:(id)sender;



@property (weak, nonatomic) IBOutlet UILabel *currentMonthLabel;

@property (weak, nonatomic) IBOutlet UILabel *monthlyBudgetLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneySpentLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UITextField *budgetField;


@end
