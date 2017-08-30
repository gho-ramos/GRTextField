//
//  GRTextField.h
//  ole-consignado
//
//  Created by Guilherme on 7/25/17.
//  Copyright © 2017 Zup IT. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE @interface GRTextField : UITextField<UITextFieldDelegate>

/**
 Define the pattern that the textField will mask, if there is no pattern
 the textField will accept alphanumeric input, otherwise only numbers will be accepted
 */
@property (nonatomic, strong) IBInspectable NSString* maskPattern;


/**
 Error message or Key to display on our error label field
 */
@property (nonatomic, strong) IBInspectable NSString* errorMessageKey;

/**
 Color of  the field border
 */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;


/**
 IBOutlet to define an error message for the field
 */
@property (nonatomic, strong) IBOutlet UILabel* errorLabel;


/**
 Define if the field will have a border
 */
@property (nonatomic) IBInspectable BOOL hasBorder;


/**
 Set error message / key GRTextField's error label

 @param visible show field or not
 */
- (void)setError:(BOOL)visible;
@end
