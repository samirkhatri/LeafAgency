//
//  PurchasedViewController.m
//  Stripe
//
//  Created by Samir on 2/5/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import "PurchasedViewController.h"
#import "AppDelegate.h"
@interface PurchasedViewController ()

@end

@implementation PurchasedViewController


+(PurchasedViewController *)initViewController:(NSString *)currency{
    PurchasedViewController *controller = [[PurchasedViewController alloc]initWithNibName:@"PurchasedViewController" bundle:nil];
    controller.currencytxt = currency;
    controller.title = @"Transaction";
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _lblCurrencytxt.text = [NSString stringWithFormat:@"Your payment of %@ for Product XXX has been processed successfully.\nWe will send you confirmation email shortly.",_currencytxt];
    [_lblCurrencytxt sizeToFit];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 25,25)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem =backButtonItem;
    
    
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 25,25)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(userDidLogout)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mainButton =[[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.rightBarButtonItem =mainButton;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)goBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)userDidLogout{
    [self goBack];
    [[AppDelegate appDelegate]logout];
    
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
