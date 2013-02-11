//
//  Welcome.h
//  iWallet
//
//  Created by lab on 2/4/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Welcome : UIView{
    IBOutlet UIPickerView *pickerView;
    NSMutableArray *list;
    IBOutlet UILabel *pickLabel;
}
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIPickerView *currencyBox;
@property (weak, nonatomic) IBOutlet UITextField *budgetLabel;


- (IBAction)saveSettings:(id)sender;


@end
