//
//  Utility.m
//  Stripe
//
//  Created by Samir on 2/5/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import "Utility.h"

@implementation Utility


+(BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



+(NSString *)getStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *str = [dateFormatter stringFromDate:date];
    return str;
}

+(NSString *)getMonthYearStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/yyyy"];
    NSString *str = [dateFormatter stringFromDate:date];
    return str;
}
@end
