//
//  GRTextField.m
//  Pods
//
//  Created by Guilherme on 8/30/17.
//
//

#import "GRTextField.h"
#import "NSString+GRTextField.h"

@interface GRTextField()<UITextFieldDelegate>
@property (nonatomic, weak) id<UITextFieldDelegate> extension;
@property (nonatomic, strong) CALayer *border;
@end

@implementation GRTextField
@synthesize key = _key;
@synthesize border = _border;
@synthesize errorFont = _errorFont;
@synthesize borderColor = _borderColor;
@synthesize errorBorderColor = _errorBorderColor;
@synthesize selectedBorderColor = _selectedBorderColor;

NSString *const selectionRangeKey = @"selectionRange";
-(void)awakeFromNib {
    [super awakeFromNib];
    [super setDelegate:self];
    self.isValid = YES;
    if (self.hasBorder) {
        self.borderStyle = UITextBorderStyleNone;
    }
    
    if (self.maskPattern) {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (self.errorLabel) {
        self.errorLabel.text = @"";
        
        [self.errorLabel setHidden:YES];
        self.errorLabel.textColor = self.errorBorderColor;
        
        self.errorLabel.numberOfLines = 0;
        self.errorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
}

#pragma mark -
#pragma mark - Getters and Setters
-(void)setDelegate:(id<UITextFieldDelegate>)delegate {
    self.extension = delegate;
}

-(void)setIsValid:(BOOL)isValid {
    _isValid = isValid;
    
    [self setColorsOfField];
    
    [self.errorLabel setHidden:_isValid];
}

-(void)setMaskPattern:(NSString *)maskPattern {
    _maskPattern = maskPattern;
    if (![NSString isNullOrEmpty:maskPattern]) {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
}

-(void)setBorder:(CALayer *)border {
    _border = border;
}

-(CALayer *)border {
    if (!_border) {
        _border = [CALayer new];
        _border.backgroundColor = self.borderColor.CGColor;
        _border.frame = ({
            CGRect frame = _border.frame;
            frame.origin = CGPointMake(self.bounds.origin.x, CGRectGetMaxY(self.bounds) - 1);
            frame.size = CGSizeMake(self.bounds.size.width, CGRectGetMaxY(self.bounds) - 1);
            frame;
        });
    }
    return _border;
}

-(UIColor *)borderColor {
    if (_borderColor == nil) {
        _borderColor = [UIColor lightGrayColor];
    }
    return _borderColor;
}

-(void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
}

-(UIColor *)errorBorderColor {
    if (_errorBorderColor == nil) {
        _errorBorderColor = [UIColor redColor];
    }
    return _errorBorderColor;
}

-(void)setErrorBorderColor:(UIColor *)errorBorderColor {
    _errorBorderColor = errorBorderColor;
}

-(UIColor *)selectedBorderColor {
    if (_selectedBorderColor == nil) {
        _selectedBorderColor = [UIColor blueColor];
    }
    return _selectedBorderColor;
}

-(void)setSelectedBorderColor:(UIColor *)selectedBorderColor {
    _selectedBorderColor = selectedBorderColor;
}

-(void)setEnabledField:(BOOL)enabledField {
    self.enabled = enabledField;
    if (self.enabled) {
        self.textColor = [UIColor blackColor];
        self.border.backgroundColor = self.borderColor.CGColor;
    } else {
        self.textColor = self.borderColor;
        self.border.backgroundColor = self.borderColor.CGColor;
    }
}

-(UIFont *)errorFont {
    if (_errorFont == nil) {
        if (self.errorLabel != nil) {
            _errorFont = self.errorLabel.font;
        } else {
            _errorFont = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        }
    }
    return _errorFont;
}

-(void)setErrorFont:(UIFont *)errorFont {
    _errorFont = errorFont;
    
    if (self.errorLabel != nil) {
        self.errorLabel.font = _errorFont;
    }
}

-(NSString *)unmaskedText {
    if (self.maskPattern) {
        return [self.text grUnmaskedString];
    }
    return self.text;
}

#pragma mark -
#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.extension respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.extension textFieldShouldBeginEditing:textField];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.extension respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.extension textFieldDidBeginEditing:textField];
    }
    [self setColorsOfField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.extension respondsToSelector:@selector(textFieldShouldEndEditing:)] && ![self.extension textFieldShouldEndEditing:textField]) {
        return NO;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.extension respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.extension textFieldDidEndEditing:textField];
    }
    [self setColorsOfField];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.extension respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] &&
        ![self.extension textField:textField shouldChangeCharactersInRange:range replacementString:string]) {
        return NO;
    }
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.maskPattern) {
        textField.text = [text maskWithPattern:self.maskPattern];
    } else if (self.maxCharacters > 0) {
        if (text.length <= self.maxCharacters) {
            textField.text = text;
        }
    } else {
        textField.text = text;
    }
    
    if(![NSString isNullOrEmpty:textField.text] && (self.errorLabel && !self.errorLabel.isHidden)) {
        [self setError:NO];
    }
    
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([self.extension respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.extension textFieldShouldClear:textField];
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.extension respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.extension textFieldShouldReturn:textField];
    }
    return YES;
}

#pragma mark -
#pragma mark - GRTextField Methods
-(void)setColorsOfField {
    CGColorRef color;
    CGFloat height;
    if (self.isValid) {
        if (self.isFirstResponder) {
            color = self.selectedBorderColor.CGColor;
        } else {
            color = self.borderColor.CGColor;
        }
        height = 1;
    } else {
        color = self.errorBorderColor.CGColor;
        height = 2;
    }
    self.border.backgroundColor = color;
    self.border.frame = ({
        CGRect frame = self.border.frame;
        frame.size.height = height;
        frame;
    });
}

- (void)resizeErrorLabelToFit {
    if (self.errorLabel) {
        CGRect bounds = [self.errorLabel textRectForBounds:self.frame limitedToNumberOfLines:0];
        bounds.origin = self.errorLabel.frame.origin;
        self.errorLabel.frame = bounds;
    }
}

- (void)setError:(BOOL)visible {
    if (visible) {
        [self setErrorWithMessage:[self.errorMessageKey localized]];
    } else {
        [self setErrorWithMessage:nil];
    }
}

- (void)setErrorWithMessage:(NSString *)message {
    self.isValid = [NSString isNullOrEmpty:message];
    if (!self.isValid) {
        self.errorLabel.text = message;
    } else {
        self.errorLabel.text = @"";
    }
    [self resizeErrorLabelToFit];
}

- (void)drawRect:(CGRect)rect {
    if (_hasBorder) {
        [self.layer addSublayer:self.border];
    }
}


@end
