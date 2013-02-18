//
//  FirstViewController.m
//  iWallet
//
//  Created by lab on 1/22/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize currentMonthLabel;

@synthesize monthlyBudgetLabel;
@synthesize moneySpentLabel;
@synthesize moneyLeftLabel;
@synthesize statusLabel;
@synthesize budgetField;


NSString *currency =@""; //load from settings

-(void) currentMonth{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [dateFormatter dateFromString:@"20111010"];
    
    // set swedish locale
    //    dateFormatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"sv_SE"];;
    
    dateFormatter.dateFormat=@"MMMM";
    NSString * monthString = [[dateFormatter stringFromDate:date] capitalizedString];
   // [currentMonthLabel setText: [@"Current month: 	" stringByAppendingString:monthString]];
    [currentMonthLabel setText: monthString];

    // NSLog(@"month: %@", monthString);
    
}
-(void) moneyLeft{
    //get value from settings
    double monthlyBudget = 100;
    [monthlyBudgetLabel setText: [NSString stringWithFormat:@"%.2f", monthlyBudget]];

    //get sum of spent money
    double spentMoney = 333.45;
    [moneySpentLabel setText: [NSString stringWithFormat:@"%.2f", spentMoney]];
    
    double moneyLeft = monthlyBudget - spentMoney;
    [moneyLeftLabel setText: [NSString stringWithFormat:@"%.2f", moneyLeft]];
    if (moneyLeft > 0) {
        moneyLeftLabel.textColor = [UIColor greenColor];
    }
    else
        moneyLeftLabel.textColor = [UIColor redColor];
    
    
 
}

- (IBAction)setEuro:(id)sender{
    currency = @"€";
    [self changeStatus:@"Currency set to euro"];
    
}

- (IBAction)setDollar:(id)sender {
    currency = @"$";
    [self changeStatus:@"Currency set to dollar"];
}


- (IBAction)setPound:(id)sender {
    currency = @"£";
    [self changeStatus:@"Currency set to pound"];
}

- (IBAction)setBudget:(id)sender {
   

    NSString *string1 = @"Budget set to ";
    NSString *string2 = [budgetField text];
    
    string1 = [string1 stringByAppendingString:string2];
    
   [self changeStatus:string1];
}

-(void)changeStatus:(NSString *)information{
    
    [statusLabel setText:information];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self currentMonth];
    [self moneyLeft];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
