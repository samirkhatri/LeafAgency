//
//  AppDelegate.h
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignInViewController.h"
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;


+(AppDelegate*)appDelegate;
-(BOOL)isReachable;
-(void)showLogin:(BOOL)animated;
-(void)userDidlogin;
-(void)logout;
@end

