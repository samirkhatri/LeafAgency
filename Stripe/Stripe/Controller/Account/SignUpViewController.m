//
//  SignUpViewController.m
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import "SignUpViewController.h"
#import "AppDelegate.h"
#import "CAccount.h"
#import "ActivityIndicator.h"
#import "AccountManager.h"
#import "Constants.h"
#import "Utility.h"
@interface SignUpViewController ()<UITextFieldDelegate,AccountAuthenticateDelegate>

@end

@implementation SignUpViewController

+(SignUpViewController *)initViewController{
    SignUpViewController *controller = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    controller.title = @"Sign Up";
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //_scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 600);
    segment_index = 1;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnNextClicked:(id)sender{
    NSString *message;
    if (txtName.text.length <= 0) {
        message = @"Please enter your email";
    }else if (txtEmail.text.length <= 0){
        message = @"Please enter email";
    }else if (![Utility validateEmailWithString:txtEmail.text]){
        message = @"Please enter valid email";
    }else if (txtPassword.text.length <= 0){
        message = @"Please enter password";
    }else if (txtConfirmPassword.text.length <= 0){
        message = @"Please enter confirm password";
    }else if (txtDateOfBirth.text.length <= 0){
        message = @"Please enter date of birth";
    }
    if (message.length > 0) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
        [self performSelector:@selector(userdidLogin) withObject:self afterDelay:4.0];
    }
    
}

-(void)userdidLogin{
    CAccount *account = [[CAccount alloc]init];
    [account saveCredential:txtEmail.text andPassword:txtPassword.text WithDelegate:self];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == txtDateOfBirth) {
        [self openDatePickerForTextField:textField];
    }
}

-(void)openDatePickerForTextField:(UITextField *)textField{
    datepicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    UIToolbar *date_accessory = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    date_accessory.tintColor = [UIColor whiteColor];
    date_accessory.translucent=NO;
    date_accessory.barTintColor=[UIColor colorWithRed:64.0/225.0f green:196.0/225.0f blue:223.0/255.0f alpha:1.0];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem  *date_button = [[UIBarButtonItem alloc]initWithTitle:@"DONE" style:UIBarButtonItemStylePlain target:self action:@selector(setBirthDate)];
    UIBarButtonItem  *cancel_button = [[UIBarButtonItem alloc]initWithTitle:@"CANCEL" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClicked)];
    date_accessory.items = [[NSArray alloc]initWithObjects:cancel_button,flexibleItem,date_button, nil];
    textField.inputView = datepicker;
    textField.inputAccessoryView = date_accessory;
    datepicker.datePickerMode = UIDatePickerModeDate;
}
-(void)btnSegmentValueChange:(UISegmentedControl *)sender{
    int j = (int)[sender selectedSegmentIndex];
    if (j == 1) {
        segment_index = 1;
    }else{
        segment_index = 2;
    }
}


-(void)setBirthDate{
    txtDateOfBirth.text = [Utility getStringFromDate:datepicker.date];
     [self.view endEditing:YES];
}

-(void)cancelBtnClicked{
    [self.view endEditing:YES];
}

#pragma mark -AccountAuthenticateDelegate
-(void)accountAuthenticatedWithAccount:(CAccount *)account{
    [[ActivityIndicator currentIndicator]displayCompleted];
    [AccountManager Instance].activeAccount = account;
    [[AppDelegate appDelegate] userDidlogin];
}

-(void)accountDidFailAuthentication:(NSError *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];

}
@end
