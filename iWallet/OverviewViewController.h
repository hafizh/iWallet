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

- (IBAction)setDollar:(id)sender;
- (IBAction)setEuro:(id)sender;
- (IBAction)setPound:(id)sender;

- (void)saveToNSUserDefaults;

- (IBAction)setBudget:(id)sender;



@property (weak, nonatomic) IBOutlet UILabel *currentMonthLabel;

@property (weak, nonatomic) IBOutlet UILabel *monthlyBudgetLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneySpentLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) IBOutlet UITextField *budgetField;
-(IBAction)textFieldReturn:(id)sender;	


@end
