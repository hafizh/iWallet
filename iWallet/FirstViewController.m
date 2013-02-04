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

@synthesize currentMonth;

@synthesize monthlyBudgetLabel;
@synthesize moneySpentLabel;
@synthesize moneyLeftLabel;

-(void) currentMonth{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [dateFormatter dateFromString:@"20111010"];
    
    // set swedish locale
    //    dateFormatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"sv_SE"];;
    
    dateFormatter.dateFormat=@"MMMM";
    NSString * monthString = [[dateFormatter stringFromDate:date] capitalizedString];
    [currentMonth setText: [@"Current month: 	" stringByAppendingString:monthString]];
    // NSLog(@"month: %@", monthString);
    
}
-(void) moneyLeft{
    //get value from settings
    double monthlyBudget = 1000;
    [monthlyBudgetLabel setText: [NSString stringWithFormat:@"%.2f", monthlyBudget]];
    //[monthlyBudgetLabel setText: @"aaa"];
    //get sum of spent money
    double spentMoney = 333.45;
    [moneySpentLabel setText: [NSString stringWithFormat:@"%.2f", spentMoney]];
    double moneyLeft = monthlyBudget - spentMoney;
    [moneyLeftLabel setText: [NSString stringWithFormat:@"%.2f", moneyLeft]];
    
    
    //
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
