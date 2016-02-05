//
//  Utility.h
//  Stripe
//
//  Created by Samir on 2/5/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject


+(BOOL)validateEmailWithString:(NSString*)email;
+(NSString *)getStringFromDate:(NSDate *)date;
+(NSString *)getMonthYearStringFromDate:(NSDate *)date;
@end
