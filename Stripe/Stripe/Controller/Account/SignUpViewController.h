//
//  SignUpViewController.h
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
@interface SignUpViewController : UIViewController
{
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet UITextField *txtDateOfBirth;
    __weak IBOutlet UITextField *txtConfirmPassword;
    __weak IBOutlet  TPKeyboardAvoidingScrollView*_scrollView;
    UIDatePicker *datepicker;
    int segment_index;
}
@property(nonatomic,strong)IBOutlet UISegmentedControl *segmentedControl;
+(SignUpViewController *)initViewController;
-(IBAction)btnSegmentValueChange:(id)sender;
-(IBAction)btnNextClicked:(id)sender;
@end
