//
//  SecondViewController.m
//  iWallet
//
//  Created by lab on 1/22/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)b1Action:(id)sender {
    

    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"clothing.png"]];
    [_categoryLabel setText:@"Clothing"];
    acategory = @"Clothing";
 
}

- (IBAction)b2Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"food.png"]];
    [_categoryLabel setText:@"Food & Groceries"];
    acategory = @"Food & Groceries";
    
}

- (IBAction)b3Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"go.png"]];
    [_categoryLabel setText:@"Going Out"];
    acategory = @"Going Out";
    
}

- (IBAction)b4Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"health.png"]];
    [_categoryLabel setText:@"Health Care & Cosmetics"];
    acategory = @"Health Care & Cosmetics";
    
}

- (IBAction)b5Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"household.png"]];
    [_categoryLabel setText:@"Household & Rent"];
    acategory = @"Houshold & Rent";
    
}

- (IBAction)b6Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"sport.png"]];
    [_categoryLabel setText:@"Sport & Hobbies"];
    acategory = @"Sports & Hobbies";
    
}

- (IBAction)b7Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"study.png"]];
    [_categoryLabel setText:@"Study Cost"];
    acategory = @"Study Costs";
    
}

- (IBAction)b8Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"transportation.png"]];
    [_categoryLabel setText:@"Transportation & Travel"];
    acategory = @"Transportation & Travel";
    
}

- (IBAction)b9Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"others.png"]];
    [_categoryLabel setText:@"Others"];
    acategory = @"Other";
    
}

- (IBAction)saveAction:(id)sender {
    
    
    //SAVE IN THE DATABASE
    ec = [EntityController getInstance];
    factory = ec.factory;
    item = factory.createSpendingItem;
    item.category = [ec.dataAccessLayer getCategoryWithName:acategory];
    item.price = [NSNumber numberWithDouble:[_textfield.text doubleValue]];
    item.desc = _textfield2.text;
    item.date = [NSDate date];
    [ec.dataAccessLayer saveContext];
    [self changeViewSecond];
    
    _action.text = @"SAVED";

}

- (IBAction)cancelAction:(id)sender {
    
    [self changeViewSecond];
    
    _action.text = @"CANCELLED";
    
}

- (IBAction)textAction:(id)sender {
    

    
}

- (void) changeViewFirst
{
    
    _b1.hidden = YES;
    _b2.hidden = YES;
    _b3.hidden = YES;
    _b4.hidden = YES;
    _b5.hidden = YES;
    _b6.hidden = YES;
    _b7.hidden = YES;
    _b8.hidden = YES;
    _b9.hidden = YES;
    
    _textfield.hidden = NO;
    _textfield2.hidden = NO;
    _savebutton.hidden = NO;
    _cancelbutton.hidden = NO;
    _category.hidden = NO;
    _categoryLabel.hidden = NO;
    
    _action.hidden = YES;
    
    [_textfield becomeFirstResponder];

}

- (void) changeViewSecond
{
    
    _b1.hidden = NO;
    _b2.hidden = NO;
    _b3.hidden = NO;
    _b4.hidden = NO;
    _b5.hidden = NO;
    _b6.hidden = NO;
    _b7.hidden = NO;
    _b8.hidden = NO;
    _b9.hidden = NO;
    
    _textfield.hidden = YES;
    _textfield2.hidden = YES;
    _savebutton.hidden = YES;
    _cancelbutton.hidden = YES;
    _category.hidden = YES;
    _categoryLabel.hidden = YES;
    
    _action.hidden = NO;
    
    [_textfield resignFirstResponder];
    [_textfield2 resignFirstResponder];
    
    _textfield.text = @"";
    _textfield2.text = @"";
    
}

@end
