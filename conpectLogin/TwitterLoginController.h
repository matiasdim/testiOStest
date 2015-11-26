//
//  TwitterLoginController.h
//  conpectLogin
//
//  Created by Matías Gil on 11/19/15.
//  Copyright © 2015 AllianceTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>

@interface TwitterLoginController : NSObject {
    TWTRLogInButton *loginButton;
}

@property(nonatomic, weak) id delegate;

+(id)sharedInstance;

-(TWTRLogInButton *)loginButton;
-(void)logout;
@end