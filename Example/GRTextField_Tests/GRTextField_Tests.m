//
//  GRTextField_Tests.m
//  GRTextField_Tests
//
//  Created by Guilherme on 10/29/17.
//  Copyright © 2017 guilherme.hor@gmail.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <GRTextField/GRTextField.h>
#import <GRTextField/NSString+GRTextField.h>

@import Nimble;

@interface GRTextField_Tests : XCTestCase

@end

@implementation GRTextField_Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testStringNullability {
    expect([NSString GRIsNullOrEmpty:nil]).to(equal(true));
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

-(void)testGRTextFieldKeyBoardType {
    GRTextField * textField = [GRTextField new];
    textField.maskPattern = @"##/##";
    expect(@(textField.keyboardType)).to(equal(@(UIKeyboardTypeNumberPad)));
}

@end
