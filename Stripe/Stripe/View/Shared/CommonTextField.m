//
//  CommonTextField.m
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import "CommonTextField.h"

@implementation CommonTextField

-(void)awakeFromNib{
    self.layer.borderWidth = 2.0f;
    self.layer.borderColor = [UIColor colorWithRed:240.0/255.0f green:241.0/255.0f blue:245.0/255.0f alpha:1.0].CGColor;
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.size.width = bounds.size.width - 15.5f;
    return CGRectInset( bounds , 10 , 9 );
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds.size.width = bounds.size.width - 15.5f;
    return CGRectInset( bounds , 10 , 9 );
}
@end
