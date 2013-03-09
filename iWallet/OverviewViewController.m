//
//  FirstViewController.m
//  iWallet
//
//  Created by lab on 1/22/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "OverviewViewController.h"
#import "DatabaseExample.h"
#import "DataQueries.h"
#import "EntityController.h"

@interface OverviewViewController ()

@end

@implementation OverviewViewController

@synthesize currentMonthLabel;

@synthesize monthlyBudgetLabel;
@synthesize moneySpentLabel;
@synthesize moneyLeftLabel;
@synthesize statusLabel;
@synthesize budgetField;
@synthesize dollar;
@synthesize pound;
@synthesize euro;
@synthesize currencyLabel;


NSString *currency; //load from settings
double monthlyBudget;
NSUserDefaults *prefs;

-(void) currentMonth{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [NSDate date];
   // NSDate *date = [dateFormatter dateFromString:@"20111010"];
    
   
    dateFormatter.dateFormat=@"MMMM";
    NSString * monthString = [[dateFormatter stringFromDate:date] capitalizedString];
   
    [currentMonthLabel setText: monthString];

    // NSLog(@"month: %@", monthString);
    
}
-(void) moneyLeft{
  
///HERE
   // EntityController *en = [EntityController getInstance] ;
  //  DataAccessLayer *dal = [en dataAccessLayer];
    DataQueries *queries = [[DataQueries alloc] init];
    NSDate *date = [NSDate date];
    NSDateComponents *month = [[NSCalendar currentCalendar] components:NSDayCalendarUnit| NSMonthCalendarUnit | NSYearCalendarUnit  fromDate:date];
    
    NSArray *filteredItems = [queries getSpendingsForMonth:month withSortDescriptor:nil];
    NSNumber *totalSpendingAmount = [filteredItems valueForKeyPath:@"@sum.price"];
    NSLog(@"%@",totalSpendingAmount);

    //get sum of spent money of this month
    double spentMoney = [totalSpendingAmount doubleValue];
   
    
    if (currency==nil) {
        currency =@"€";
    }
    
    double moneyLeft = monthlyBudget - spentMoney;
    if ([currency isEqualToString: @"$"] || [currency isEqualToString: @"£"])  {
        [monthlyBudgetLabel setText: [NSString stringWithFormat:@"%@%.2f", currency, monthlyBudget]];
        [moneySpentLabel setText: [NSString stringWithFormat:@"%@%.2f", currency, spentMoney]];
        [moneyLeftLabel setText: [NSString stringWithFormat:@"%@%.2f", currency, moneyLeft]];
    }
    else{
    [monthlyBudgetLabel setText: [NSString stringWithFormat:@"%.2f%@", monthlyBudget, currency]];
    [moneySpentLabel setText: [NSString stringWithFormat:@"%.2f%@", spentMoney, currency]];
    [moneyLeftLabel setText: [NSString stringWithFormat:@"%.2f%@", moneyLeft, currency]];
    }
    
    if (moneyLeft > 0) {
        moneyLeftLabel.textColor = [UIColor colorWithRed:0 green:0.7 blue:0 alpha:1.0];
    }
    else
        moneyLeftLabel.textColor = [UIColor colorWithRed:0.7 green:0 blue:0 alpha:1.0];
    
    
 
}

- (IBAction)euroActive:(id)sender{
    currency = @"€";
    [self changeStatus:@"Currency set to euro"];
    [self saveToNSUserDefaults];
    
    [prefs setBool:NO forKey:@"currencyBOOL"];
    [self currencyBar];
    
}

- (IBAction)dollarActive:(id)sender {
    currency = @"$";
    [self changeStatus:@"Currency set to dollar"];
    [self saveToNSUserDefaults];
    
    [prefs setBool:NO forKey:@"currencyBOOL"];
    [self currencyBar];
    
}


- (IBAction)poundActive:(id)sender {
    currency = @"£";
    [self changeStatus:@"Currency set to pound"];
    [self saveToNSUserDefaults];
    
    [prefs setBool:NO forKey:@"currencyBOOL"];
    [self currencyBar];
}

- (IBAction)setBudget:(id)sender {
   

    NSString *string1 = @"Budget set to ";
    NSString *string2 = [budgetField text];
    
    string1 = [string1 stringByAppendingString:string2];
    
   [self changeStatus:string1];
    monthlyBudget = [[budgetField text] doubleValue];
   [self saveToNSUserDefaults];
   [budgetField resignFirstResponder];    
}

-(void)saveToNSUserDefaults {
   
    [prefs setObject:currency forKey:@"currency"];
    [prefs setFloat:monthlyBudget forKey:@"Monthly budget"];

    [self moneyLeft];

}

-(void)loadCurrencyFromNSUserDefaults {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
        currency = [prefs stringForKey:@"currency"];
    monthlyBudget = [prefs floatForKey:@"Monthly budget"];

}

-(void)changeStatus:(NSString *)information{
    
    [statusLabel setText:information];
}


-(IBAction)backgroundTouched:(id)sender{
    [budgetField resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    
    prefs = [NSUserDefaults standardUserDefaults];
	
    
    [self loadCurrencyFromNSUserDefaults];
    if(currency)
    {
    
    
    }
    [self currentMonth];
    [self moneyLeft];
    
    [self currencyBar];
    NSLog(@"START");
    
    [self moneyLeft];
}



-(void) currencyBar{

    BOOL currencySettings = [prefs boolForKey:@"currencyBOOL"];
    NSLog(currencySettings ? @"currency settings is on" : @"currency settings is off");
    
    if(currencySettings == NO) {
        dollar.hidden = YES;
        euro.hidden = YES;
        pound.hidden = YES;
        currencyLabel.hidden = YES;
       
        budgetField.hidden = YES;
        _budgetLabel.hidden = YES;
        _budgetSave.hidden = YES;
        
    }
    else {
        dollar.hidden = NO;
        euro.hidden = NO;
        pound.hidden = NO;
        currencyLabel.hidden = NO;
        
        budgetField.hidden = NO;
        _budgetLabel.hidden = NO;
        _budgetSave.hidden = NO;
        
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//keyboard
#define kOFFSET_FOR_KEYBOARD 180.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:budgetField])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;

    
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
     		   rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
      NSLog(@"view will appear");
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self loadCurrencyFromNSUserDefaults];
    [self currencyBar];
    [self moneyLeft];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

@end
