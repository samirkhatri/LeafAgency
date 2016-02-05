

#import <Foundation/Foundation.h>

@class CAccount;
@protocol AccountAuthenticateDelegate <NSObject>

-(void)accountAuthenticatedWithAccount:(CAccount*) account;
-(void)accountDidFailAuthentication:(NSError*) error;

@end
