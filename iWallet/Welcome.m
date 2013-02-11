//
//  Welcome.m
//  iWallet
//
//  Created by lab on 2/4/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "Welcome.h"

@implementation Welcome

@synthesize continueButton;
@synthesize currencyBox;
@synthesize budgetLabel;

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component{
    return [list count];
}
-(NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [list objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *string = [NSString stringWithFormat:@"You selected: %@", [list objectAtIndex:row]];
    pickLabel.text = string;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (IBAction)saveSettings:(id)sender {
    
    UIAlertView *myAlert = [[UIAlertView alloc]
                            initWithTitle:@"Alert title"
                            message:@"There was a problem"
                            delegate:nil
                            cancelButtonTitle:@"Ok"
                            otherButtonTitles:nil];
    [myAlert show];
}


-(void)viewDidLoad{
    //[super viewDidLoad];
    list=[[NSMutableArray alloc] init];
    [list addObject:@"Euro"];
    [list addObject:@"Dolar"];
    [list addObject:@"PLN"];
    [list addObject:@"1"];
    [list addObject:@"2"];
    [list addObject:@"3"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
