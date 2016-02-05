//
//  SignInViewController.m
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import "SignInViewController.h"
#import "AccountAuthenticateDelegate.h"
#import "SignUpViewController.h"
#import "ActivityIndicator.h"
#import "AccountManager.h"
#import "CAccount.h"
#import "AppDelegate.h"
#import "Utility.h"
#import "Constants.h"
@interface SignInViewController ()<AccountAuthenticateDelegate>

@end

@implementation SignInViewController

+(SignInViewController *)initViewController{
    SignInViewController *controller = [[SignInViewController alloc]initWithNibName:@"SignInViewController" bundle:nil];
    controller.title = @"Sign in";
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //_scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 600);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnSignInClicked:(id)sender{
    NSString *message;
    if (txtEmail.text.length <= 0) {
        message = @"Please enter email";
    }else if (![Utility validateEmailWithString:txtEmail.text]){
        message = @"Please enter valid email";
    }else if (txtPassword.text.length <= 0){
        message = @"Please enter password";
    }
    if (message.length > 0) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        [self performSelector:@selector(userdidLogin) withObject:self afterDelay:4.0];
    }
    
}
-(void)userdidLogin{
    CAccount *account = [[CAccount alloc]init];
    [account saveCredential:txtEmail.text andPassword:txtPassword.text WithDelegate:self];
}
-(void)btnCreateAccountClicked:(id)sender{
    SignUpViewController *controller = [SignUpViewController initViewController];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)accountAuthenticatedWithAccount:(CAccount *)account{
    [[ActivityIndicator currentIndicator]displayCompleted];
    [AccountManager Instance].activeAccount = account;
    [[AppDelegate appDelegate] userDidlogin];
}

-(void)accountDidFailAuthentication:(NSError *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
