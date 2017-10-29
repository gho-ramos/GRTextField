//
//  GRTextField_Tests.m
//  GRTextField_Tests
//
//  Created by Guilherme on 10/29/17.
//  Copyright © 2017 guilherme.hor@gmail.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <GRTextField/NSString+GRTextField.h>

@import Nimble;

@interface GRTextField_Tests : XCTestCase

@end

@implementation GRTextField_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStringNullability {
    expect([NSString isNullOrEmpty:nil]).to(equal(true));
}

- (void)testStringMaskPattern {
    NSString * pattern = @"##/##";
    NSString * datevalue = @"0102";
    
    expect([datevalue maskWithPattern:pattern]).to(equal(@"01/02"));
}

- (void)testUnmaskedPattern {
    NSString * pattern = @"##/##";
    NSString * datevalue = @"0102";
    NSString * masked = [datevalue maskWithPattern:pattern];
    expect([masked grUnmaskedString]).to(equal(datevalue));
}

@end
