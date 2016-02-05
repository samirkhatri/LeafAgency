//
//  AccountAuthenticateDelegate.h
//  FieldWork
//
//  Created by Samir Kha on 06/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EAccount;

@protocol AccountAuthenticateDelegate <NSObject>

-(void)accountAuthenticatedWithAccount:(EAccount*) account;
-(void)accountDidFailAuthentication:(NSError*) error;

@end
