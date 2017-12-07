//
//  GRTextField.h
//  Pods
//
//  Created by Guilherme on 8/30/17.
//
//

#import <UIKit/UIKit.h>
#import "ErrorTextFieldProtocol.h"

IB_DESIGNABLE @interface GRTextField : UITextField <ErrorTextFieldProtocol>

/**
 Define the pattern that the textField will mask, if there is no pattern
 the textField will accept alphanumeric input, otherwise only numbers will be accepted.
 
 P.S.: if this property is set the field will ignore maxCharacters property
 */
@property (nonatomic, strong) IBInspectable NSString* maskPattern;


/**
 Define the hint text that will be shown in place of the error while the field is valid

 P.S.: if this property is not set, it will hide the error label
 */
@property (nonatomic, strong) IBInspectable NSString* hintText;

/**
 Error message or Key to display on our error label field
 if there is a key onto localizableStrings file it will automatically localize the message
 according to the specified key.
 If the string isn't specified onto LocalizableStrings file, it will be used on the error label;
 */
@property (nonatomic, strong) IBInspectable NSString* errorMessageKey;

/**
 Define if the field will have a border
 */
@property (nonatomic) IBInspectable BOOL hasBorder;

/**
 Define the max number of characters if there's no mask pattern defined.
 defaults to 0;
 */
@property (nonatomic) IBInspectable int maxCharacters;

/**
 Color of  the field border
 defaults to [UIColor lightGrayColor]
 */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

/**
 Color of  the field border on error
 defaults to [UIColor redColor]
 */
@property (nonatomic, strong) IBInspectable UIColor *errorBorderColor;

/**
 Color of  the field border on selection
 defaults to [UIColor blueColor]
 */
@property (nonatomic, strong) IBInspectable UIColor *selectedBorderColor;

/**
 Set field text insets for height and width
 */
@property (nonatomic) IBInspectable CGPoint textInsets;

/**
 IBOutlet to define an error message for the field
 */
@property (nonatomic, strong) IBOutlet UILabel* errorLabel;

/**
 Custom font for error label
 */
@property (nonatomic, strong) UIFont *errorFont;

/**
 Text without mask
 */
@property (nonatomic, strong) NSString *unmaskedText;

/**
 Flag defining if the textField is Valid
 defaults to YES;
 */
@property (nonatomic, assign) BOOL isValid;

/**
 Set field status and change it's style
 defaults to YES;
 */
@property (nonatomic, assign) BOOL enabledField;

/**
 Set error message / key GRTextField's error label
 
 @param visible show field or not
 */
- (void)setError:(BOOL)visible;

/**
 Set error message / key GRTextField's error label
 
 @param message message / key
 */
- (void)setErrorWithMessage:(NSString*)message;
@end
