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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
