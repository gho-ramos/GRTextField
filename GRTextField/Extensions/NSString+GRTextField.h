//
//  NSString+GRTextField.h
//  Pods
//
//  Created by Guilherme on 8/30/17.
//
//

#import <Foundation/Foundation.h>

@interface NSString (GRTextField)
-(NSString *) localized;
+(BOOL)isNullOrEmpty:(NSString*)string;
-(NSString*)maskWithPattern:(NSString*)pattern;
-(NSString*)unmaskedString;
@end
