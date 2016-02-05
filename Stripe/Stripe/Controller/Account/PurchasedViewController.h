//
//  PurchasedViewController.h
//  Stripe
//
//  Created by Samir on 2/5/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchasedViewController : UIViewController


@property(nonatomic,strong)NSString *currencytxt;
@property(nonatomic,weak)IBOutlet UILabel *lblCurrencytxt;

+(PurchasedViewController *)initViewController:(NSString *)currency;
@end
