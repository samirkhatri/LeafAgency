//
//  CAccount.m
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import "CAccount.h"
#define ENCODING_VERSION        2
@implementation CAccount




- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self)
    {
        if ([aDecoder decodeIntForKey:@"version"] == ENCODING_VERSION)
        {
            _email = [aDecoder decodeObjectForKey:@"email"];
            _password = [aDecoder decodeObjectForKey:@"password"];
           
        }
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:ENCODING_VERSION forKey:@"version"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_password forKey:@"password"];
}


-(void)saveCredential:(NSString *)email andPassword:(NSString *)password WithDelegate:(id<AccountAuthenticateDelegate>)del{
    _delegate = del;
    _email = email;
    _password = password;
    if (_delegate && [_delegate respondsToSelector:@selector(accountAuthenticatedWithAccount:)]) {
        [_delegate accountAuthenticatedWithAccount:self];
    }
}
@end
