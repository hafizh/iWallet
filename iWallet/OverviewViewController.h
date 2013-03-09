//
//  FirstViewController.h
//  iWallet
//
//  Created by lab on 1/22/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverviewViewController : UIViewController{
    UITextField  *budgetField;
}

-(void) currentMonth;
-(void) moneyLeft;
-(void) changeStatus:(NSString *)information;

- (IBAction)dollarActive:(id)sender;
- (IBAction)euroActive:(id)sender;
- (IBAction)poundActive:(id)sender;

- (void)saveToNSUserDefaults;

- (IBAction)setBudget:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *dollar;
@property (weak, nonatomic) IBOutlet UIButton *euro;
@property (weak, nonatomic) IBOutlet UIButton *pound;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;

@property (weak, nonatomic) IBOutlet UIButton *budgetSave;
@property (weak, nonatomic) IBOutlet UILabel *budgetLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentMonthLabel;

@property (weak, nonatomic) IBOutlet UILabel *monthlyBudgetLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneySpentLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) IBOutlet UITextField *budgetField;

-(IBAction)backgroundTouched:(id)sender;


@end
