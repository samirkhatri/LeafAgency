//
//  PaymentViewController.h
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTMonthYearPicker.h"
#import "BKCurrencyTextField.h"
#import "BKCardNumberField.h"
@interface PaymentViewController : UIViewController
{

}
@property (weak, nonatomic) IBOutlet BKCardNumberField *cardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *txtCVV;
@property (strong, nonatomic) NTMonthYearPicker *datepicker;
@property (strong, nonatomic) IBOutlet BKCurrencyTextField *currencyTextField;
@property (weak, nonatomic) IBOutlet UITextField *txtExpiryDate;

-(IBAction)btnPayClicked:(id)sender;
+(PaymentViewController *)initViewController;
@end
