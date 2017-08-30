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
    return NSLocalizedString(self, "");
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
    NSError *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
}
@end
