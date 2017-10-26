//
//  NSString+GRTextField.m
//  Pods
//
//  Created by Guilherme on 8/30/17.
//
//

#import "NSString+GRTextField.h"

@implementation NSString (GRTextField)
-(NSString *)localized {
    NSString *key;
    NSString *path = [[NSBundle mainBundle] pathForResource:[[NSLocale currentLocale] languageCode] ofType:@"lproj"];
    if (path) {
        NSBundle *bundle = [NSBundle bundleWithPath:path];
        key = [bundle localizedStringForKey:self value:nil table:@"localizable"];
        if (key) {
            return key;
        }
    }
    return self;
}

+ (BOOL)isNullOrEmpty:(NSString *)string {
    if (string == nil || ![string isKindOfClass:[NSString class]] || [string isEqualToString:@""] || [string isEqualToString:@"null"]) {
        return YES;
    }
    return NO;
}

-(NSString *)maskWithPattern:(NSString *)pattern {
    NSInteger index = 0;
    NSString *masked = @"";
    NSString *string = [self unmaskedString];
    for (int i = 0; i < pattern.length; i++) {
        if (index >= string.length) {
            break;
        }
        NSString *replacementCharacter = [NSString stringWithFormat:@"%c", [pattern characterAtIndex:i]];
        if ([replacementCharacter isEqualToString:@"#"]) {
            masked = [masked stringByAppendingString:[NSString stringWithFormat:@"%c", [string characterAtIndex:index]]];
            index = index + 1;
        } else {
            masked = [masked stringByAppendingString:replacementCharacter];
        }
    }
    return masked;
}

-(NSString*)unmaskedString {
    
    NSString *pattern = @"\\D+";
    NSMutableString *unmaskedString = [NSMutableString new];
    
    for (int i = 0; i < self.length; i++) {
        NSCharacterSet *decimalSet = [NSCharacterSet decimalDigitCharacterSet];
        unichar c = [self characterAtIndex:i];
        if ([decimalSet characterIsMember:c]) {
            [unmaskedString appendString:[NSString stringWithFormat:@"%c", c]];
        }
    }
    
    return unmaskedString;
    
}
@end
