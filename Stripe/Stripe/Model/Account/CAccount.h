//
//  CAccount.h
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountAuthenticateDelegate.h"
@interface CAccount : NSObject
{
    NSString *tempEmail;
    NSString *tempPassword;
}
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *password;

@property(nonatomic,strong)id<AccountAuthenticateDelegate>delegate;

-(void)saveCredential:(NSString *)email andPassword:(NSString *)password WithDelegate:(id<AccountAuthenticateDelegate>)del;
@end
