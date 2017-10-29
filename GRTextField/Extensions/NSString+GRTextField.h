//
//  NSString+GRTextField.h
//  Pods
//
//  Created by Guilherme on 8/30/17.
//
//

#import <Foundation/Foundation.h>

@interface NSString (GRTextField)

/**
 Find a string for a certain provided key

 @return The localized version of the string key
 */
-(NSString *) localized;

/**
 Check if a string is null or empty

 @param string The string that will be checked
 @return A boolean value indicating wether the string is null or empty
 */
+(BOOL)isNullOrEmpty:(NSString*)string;

/**
 Transforms the string (numeric values) to match the pattern provided

 @param pattern The parameter that will be used to change the string.
 @return The transformed string matching the pattern.
 */
-(NSString*)maskWithPattern:(NSString*)pattern;

/**
 Transforms the string (numeric values) removing the pattern.

 @return The original (numeric) value of the string, without the mask pattern.
 */
-(NSString*)grUnmaskedString;
@end
