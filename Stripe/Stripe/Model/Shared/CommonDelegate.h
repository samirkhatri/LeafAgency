//
//  CommonDelegate.h
//  CKeSense
//
//  Created by Mac4 on 09/04/15.
//  Copyright (c) 2015 Samir Khatri. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommonDelegate <NSObject>

-(void) listLoadedSuccessfully:(NSString *)tag;

-(void) listLoadedWithFailed:(NSString *) error;

@end
