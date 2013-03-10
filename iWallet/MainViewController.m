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
    [_category setImage:[UIImage imageNamed:@"new1.png"]];
    [_categoryLabel setText:@"Clothing"];
    acategory = @"Clothing";
 
}

- (IBAction)b2Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"new2.png"]];
    [_categoryLabel setText:@"Food & Groceries"];
    acategory = @"Food & Groceries";
    
}

- (IBAction)b3Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"new3_4.png"]];
    [_categoryLabel setText:@"Going Out"];
    acategory = @"Going Out";
    
}

- (IBAction)b4Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"new4.png"]];
    [_categoryLabel setText:@"Health Care & Cosmetics"];
    acategory = @"Health Care & Cosmetics";
    
}

- (IBAction)b5Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"new5.png"]];
    [_categoryLabel setText:@"Household & Rent"];
    acategory = @"Houshold & Rent";
    
}

- (IBAction)b6Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"new6.png"]];
    [_categoryLabel setText:@"Sport & Hobbies"];
    acategory = @"Sports & Hobbies";
    
}

- (IBAction)b7Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"new7.png"]];
    [_categoryLabel setText:@"Study Cost"];
    acategory = @"Study Costs";
    
}

- (IBAction)b8Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"new8.png"]];
    [_categoryLabel setText:@"Transportation & Travel"];
    acategory = @"Transportation & Travel";
    
}

- (IBAction)b9Action:(id)sender {
    
    [self changeViewFirst];
    [_category setImage:[UIImage imageNamed:@"new9.png"]];
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
    
    [UIView animateWithDuration:5
                     animations:^
     {
         
         [_action setAlpha:0];
         
     }];


}

- (IBAction)cancelAction:(id)sender {
    
    [self changeViewSecond];
    
    _action.text = @"CANCELLED";
    
    [UIView animateWithDuration:5
                     animations:^
    {
    
        [_action setAlpha:0];
    
    }];

    
}

- (IBAction)textAction:(id)sender {
    

    
}

- (void) changeViewFirst
{
    
    [UIView animateWithDuration:0.3
                     animations:^
     {
         [_b1 setAlpha:0];
         [_b2 setAlpha:0];
         [_b3 setAlpha:0];
         [_b4 setAlpha:0];
         [_b5 setAlpha:0];
         [_b6 setAlpha:0];
         [_b7 setAlpha:0];
         [_b8 setAlpha:0];
         [_b9 setAlpha:0];
         
         [_textfield setAlpha:1];
         [_textfield2 setAlpha:1];
         [_savebutton setAlpha:1];
         [_cancelbutton setAlpha:1];
         [_category setAlpha:1];
         [_categoryLabel setAlpha:1];
         
     }];
    
    _action.hidden = YES;
    
    [_action setAlpha:1];
    
    [_textfield becomeFirstResponder];

}

- (void) changeViewSecond
{
    
    [UIView animateWithDuration:0.3
                     animations:^
     {
         [_b1 setAlpha:1];
         [_b2 setAlpha:1];
         [_b3 setAlpha:1];
         [_b4 setAlpha:1];
         [_b5 setAlpha:1];
         [_b6 setAlpha:1];
         [_b7 setAlpha:1];
         [_b8 setAlpha:1];
         [_b9 setAlpha:1];
         
         [_textfield setAlpha:0];
         [_textfield2 setAlpha:0];
         [_savebutton setAlpha:0];
         [_cancelbutton setAlpha:0];
         [_category setAlpha:0];
         [_categoryLabel setAlpha:0];
         
     }];
    
    _action.hidden = NO;
    
    [_textfield resignFirstResponder];
    [_textfield2 resignFirstResponder];
    
    _textfield.text = @"";
    _textfield2.text = @"";
    
}

@end
