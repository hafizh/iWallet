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
double monthlyBudget;

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
    //monthlyBudget = 100;
    
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
    [self saveToNSUserDefaults];
    
}

- (IBAction)setDollar:(id)sender {
    currency = @"$";
    [self changeStatus:@"Currency set to dollar"];
    [self saveToNSUserDefaults];
}


- (IBAction)setPound:(id)sender {
    currency = @"£";
    [self changeStatus:@"Currency set to pound"];
    [self saveToNSUserDefaults];
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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:currency forKey:@"currency"];
    [prefs setFloat:monthlyBudget forKey:@"Monthly budget"];
    [self moneyLeft];
    //[self viewDidLoad];
}

-(void)loadCurrencyFromNSUserDefaults {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
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
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

@end