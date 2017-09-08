//
//  ErrorTextFieldProtocol.h
//  Pods
//
//  Created by Guilherme on 9/8/17.
//
//

#import <Foundation/Foundation.h>

@protocol ErrorTextFieldProtocol <NSObject>
@property (nonatomic, strong) NSString *key;
-(void)setError:(BOOL)visible;
-(void)setErrorWithMessage:(NSString*)message;
@end
