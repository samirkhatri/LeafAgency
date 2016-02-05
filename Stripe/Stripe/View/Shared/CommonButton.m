//
//  CommonButton.m
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import "CommonButton.h"

@implementation CommonButton

-(void)awakeFromNib{
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.cornerRadius = 5.0f;
}

@end
