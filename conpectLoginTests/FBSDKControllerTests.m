//
//  FBSDKControllerTests.m
//  conpectLogin
//
//  Created by Matías Gil on 11/24/15.
//  Copyright © 2015 AllianceTech. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FBSDKController.h"

@interface FBSDKControllerTests : XCTestCase

@end

@implementation FBSDKControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - helper methods

- (FBSDKController *)createUniqueInstance {
    
    return [[FBSDKController alloc] init];
    
}

- (FBSDKController *)getSharedInstance {
    
    return [FBSDKController sharedInstance];
}

#pragma mark - tests

- (void)testSingletonSharedInstanceCreated {
    
    XCTAssertNotNil([self getSharedInstance]);
    
}

- (void)testSingletonUniqueInstanceCreated {
    
    XCTAssertNotNil([self createUniqueInstance]);
    
}

- (void)testSingletonReturnsSameSharedInstanceTwice {
    
    FBSDKController *sharedInstance = [self getSharedInstance];
    XCTAssertEqual(sharedInstance, [self getSharedInstance]);
    
}

- (void)testSingletonSharedInstanceSeparateFromUniqueInstance {
    
    FBSDKController *sharedInstance = [self getSharedInstance];
    XCTAssertNotEqual(sharedInstance, [self createUniqueInstance]);
}

- (void)testSingletonReturnsSeparateUniqueInstances {
    
    FBSDKController *sharedInstance = [self createUniqueInstance];
    XCTAssertNotEqual(sharedInstance, [self createUniqueInstance]);
}


@end
