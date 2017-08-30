//
//  NSString+Extension.h
//  GRTextField
//
//  Created by Guilherme on 7/25/17.
//  Copyright © 2017 Guilherme Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
-(NSString *) localized;
+(BOOL)isNullOrEmpty:(NSString*)string;
-(NSString*)maskWithPattern:(NSString*)pattern;
-(NSString*)unmaskedString;
@end
