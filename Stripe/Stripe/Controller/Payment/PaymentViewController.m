//
//  PaymentViewController.m
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import "PaymentViewController.h"
#import "ActivityIndicator.h"
#import "PurchasedViewController.h"
#import "Utility.h"
#import "Constants.h"
@interface PaymentViewController ()<UITextFieldDelegate>

@end

@implementation PaymentViewController

+(PaymentViewController *)initViewController{
    PaymentViewController *controller = [[PaymentViewController alloc]initWithNibName:@"PaymentViewController" bundle:nil];
    controller.title = @"Payment";
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
      [self.cardNumberField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    self.cardNumberField.layer.borderWidth = 2.0f;
    self.cardNumberField.layer.borderColor = [UIColor colorWithRed:240.0/255.0f green:241.0/255.0f blue:245.0/255.0f alpha:1.0].CGColor;
      self.cardNumberField.showsCardLogo = YES;
    [self.currencyTextField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    self.currencyTextField.layer.borderWidth = 2.0f;
    self.currencyTextField.layer.borderColor = [UIColor colorWithRed:240.0/255.0f green:241.0/255.0f blue:245.0/255.0f alpha:1.0].CGColor;
     self.definesPresentationContext = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldEditingChanged:(id)sender{
      if (sender == self.cardNumberField) {
          NSString *cardCompany = self.cardNumberField.cardCompanyName;
          if (nil == cardCompany) {
              cardCompany = @"unknown";
          }
          
    }
    if  (sender == self.currencyTextField) {
        
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _txtExpiryDate) {
        [self openDatePickerForTextField:textField];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == _txtCVV) {
        if (searchStr.length > 3) {
            return NO;
        }
    }
    return YES;
}

-(void)openDatePickerForTextField:(UITextField *)textField{
    _datepicker = [[NTMonthYearPicker alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    UIToolbar *date_accessory = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    date_accessory.tintColor = [UIColor whiteColor];
    date_accessory.translucent=NO;
    date_accessory.barTintColor=[UIColor colorWithRed:64.0/225.0f green:196.0/225.0f blue:223.0/255.0f alpha:1.0];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem  *date_button = [[UIBarButtonItem alloc]initWithTitle:@"DONE" style:UIBarButtonItemStylePlain target:self action:@selector(setBirthDate)];
    UIBarButtonItem  *cancel_button = [[UIBarButtonItem alloc]initWithTitle:@"CANCEL" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClicked)];
    date_accessory.items = [[NSArray alloc]initWithObjects:cancel_button,flexibleItem,date_button, nil];
    textField.inputView = _datepicker;
    textField.inputAccessoryView = date_accessory;
    _datepicker.datePickerMode = NTMonthYearPickerModeMonthAndYear;
}

-(void)setBirthDate{
    _txtExpiryDate.text = [Utility getMonthYearStringFromDate:_datepicker.date];
    [self.view endEditing:YES];

}

-(void)cancelBtnClicked{
    [self.view endEditing:YES];
}

-(void)btnPayClicked:(id)sender{
    NSString *message;
    if (_cardNumberField.text.length <= 0) {
        message = @"Please enter card number";
    }else if (_txtCVV.text.length <= 0){
        message = @"Please enter cvv";
    }else if (_txtExpiryDate.text.length <=0){
        message = @"Please enter expiry date";
    }else if (_currencyTextField.text.length <=0){
        message = @"Please enter currency";
    }
    if (message.length > 0) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
        [self performSelector:@selector(userDidPay) withObject:self afterDelay:3.0];
    }
}

-(void)userDidPay{
    [[ActivityIndicator currentIndicator]displayCompleted];
    PurchasedViewController *controller = [PurchasedViewController initViewController:_currencyTextField.text];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
