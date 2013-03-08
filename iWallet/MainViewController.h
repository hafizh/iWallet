//
//  SecondViewController.h
//  iWallet
//
//  Created by lab on 1/22/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityController.h"
#import "EntityFactory.h"
#import "SpendingItem.h"

@interface MainViewController : UIViewController
{
//NUEVA VERSION
    EntityController *ec;
    EntityFactory *factory;
    SpendingItem *item;
    NSString *acategory;
}

@property (weak, nonatomic) IBOutlet UIButton *b1;
@property (weak, nonatomic) IBOutlet UIButton *b2;
@property (weak, nonatomic) IBOutlet UIButton *b3;
@property (weak, nonatomic) IBOutlet UIButton *b4;
@property (weak, nonatomic) IBOutlet UIButton *b5;
@property (weak, nonatomic) IBOutlet UIButton *b6;
@property (weak, nonatomic) IBOutlet UIButton *b7;
@property (weak, nonatomic) IBOutlet UIButton *b8;
@property (weak, nonatomic) IBOutlet UIButton *b9;

@property (weak, nonatomic) IBOutlet UITextField *textfield2;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (weak, nonatomic) IBOutlet UIButton *savebutton;
@property (weak, nonatomic) IBOutlet UIButton *cancelbutton;

@property (weak, nonatomic) IBOutlet UIImageView *category;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UILabel *action;

- (IBAction)b1Action:(id)sender;
- (IBAction)b2Action:(id)sender;
- (IBAction)b3Action:(id)sender;
- (IBAction)b4Action:(id)sender;
- (IBAction)b5Action:(id)sender;
- (IBAction)b6Action:(id)sender;
- (IBAction)b7Action:(id)sender;
- (IBAction)b8Action:(id)sender;
- (IBAction)b9Action:(id)sender;

- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

- (IBAction)textAction:(id)sender;







@end
