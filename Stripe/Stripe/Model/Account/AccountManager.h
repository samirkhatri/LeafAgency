

#import <Foundation/Foundation.h>

@class CAccount;

@interface AccountManager : NSObject
{
    CAccount *_activeAccount;
    
    NSMutableDictionary *_savedAccounts;
}

@property (nonatomic, readwrite, retain) CAccount *activeAccount;

+(AccountManager*)Instance;

-(void)saveAccount;



@end
