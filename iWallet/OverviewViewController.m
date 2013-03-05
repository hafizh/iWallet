//
//  FirstViewController.m
//  iWallet
//
//  Created by lab on 1/22/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "OverviewViewController.h"

@interface OverviewViewController ()

@end

@implementation OverviewViewController

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
    
    [monthlyBudgetLabel setText: [NSString stringWithFormat:@"%.2f%@", monthlyBudget, currency]];

    //get sum of spent money
    double spentMoney = 333.45;
    [moneySpentLabel setText: [NSString stringWithFormat:@"%.2f%@", spentMoney, currency]];
    
    double moneyLeft = monthlyBudget - spentMoney;
    [moneyLeftLabel setText: [NSString stringWithFormat:@"%.2f%@", moneyLeft, currency]];
    if (moneyLeft > 0) {
        moneyLeftLabel.textColor = [UIColor greenColor];
    }
    else
        moneyLeftLabel.textColor = [UIColor redColor];
    
    
 
}

- (IBAction)setEuro:(id)sender{
    currency = @"€";
    [self changeStatus:@"Currency set to euro"];
    [self saveCurrencyToNSUserDefaults:currency];
    
}

- (IBAction)setDollar:(id)sender {
    currency = @"$";
    [self changeStatus:@"Currency set to dollar"];
    [self saveCurrencyToNSUserDefaults:currency];
}


- (IBAction)setPound:(id)sender {
    currency = @"£";
    [self changeStatus:@"Currency set to pound"];
    [self saveCurrencyToNSUserDefaults:currency];
}

- (IBAction)setBudget:(id)sender {
   

    NSString *string1 = @"Budget set to ";
    NSString *string2 = [budgetField text];
    
    string1 = [string1 stringByAppendingString:string2];
    
   [self changeStatus:string1];
}

-(void)saveCurrencyToNSUserDefaults:(NSString*) currency {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:currency forKey:@"currency"];
    [self moneyLeft];
    //[self viewDidLoad];
}

-(void)loadCurrencyFromNSUserDefaults {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    currency = [prefs stringForKey:@"currency"];

}

-(void)changeStatus:(NSString *)information{
    
    [statusLabel setText:information];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self currentMonth];
    [self loadCurrencyFromNSUserDefaults];
    [self moneyLeft];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
