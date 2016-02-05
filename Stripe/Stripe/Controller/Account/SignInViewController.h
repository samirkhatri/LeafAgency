//
//  SignInViewController.h
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
@interface SignInViewController : UIViewController
{
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet  TPKeyboardAvoidingScrollView*_scrollView;
}
+(SignInViewController *)initViewController;
-(IBAction)btnSignInClicked:(id)sender;
-(IBAction)btnCreateAccountClicked:(id)sender;
@end
