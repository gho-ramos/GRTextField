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
@synthesize enabled = _enabled;
@synthesize errorFont = _errorFont;
@synthesize borderColor = _borderColor;
@synthesize errorBorderColor = _errorBorderColor;
@synthesize selectedBorderColor = _selectedBorderColor;

NSString *const selectionRangeKey = @"selectionRange";
-(void)awakeFromNib {
    [super awakeFromNib];
    [super setDelegate:self];
    self.isValid = YES;
    [self initialization];
    [self layoutSubviews];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

-(void)initialization {
    [self addBottomLine];
    if (self.hasBorder) {
        self.borderStyle = UITextBorderStyleNone;
    }

    if (self.maskPattern) {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }

    if (self.errorLabel) {
        BOOL isEmpty = [NSString GRIsNullOrEmpty:self.hintText];
        if (self.isValid) {
            self.errorLabel.text = self.hintText;
            self.errorLabel.numberOfLines = 0;
            self.errorLabel.lineBreakMode = NSLineBreakByWordWrapping;

            [self.errorLabel setHidden:isEmpty];
            if (isEmpty) {
                self.errorLabel.textColor = self.errorBorderColor;
            }
        }
    }
}

- (void)addBottomLine {
    self.border.frame = ({
        CGRect frame = self.border.frame;
        frame.origin = CGPointMake(self.bounds.origin.x, CGRectGetMaxY(self.bounds) - 1);
        frame.size = CGSizeMake(self.bounds.size.width, 1);
        frame;
    });
}

-(void) updateTextField:(CGRect)frame {
    self.frame = frame;
    [self initialization];
}

#pragma mark -
#pragma mark - Getters and Setters
-(void)setDelegate:(id<UITextFieldDelegate>)delegate {
    self.extension = delegate;
}

-(void)setIsValid:(BOOL)isValid {
    _isValid = isValid;

    [self setColorsOfField];

    BOOL isValidAndEmpty = _isValid && [NSString GRIsNullOrEmpty:self.hintText];

    [self.errorLabel setHidden:isValidAndEmpty];
}

-(void)setMaskPattern:(NSString *)maskPattern {
    _maskPattern = maskPattern;
    if (![NSString GRIsNullOrEmpty:maskPattern]) {
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
        [self.layer addSublayer:_border];
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

-(void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    if (_enabled) {
        self.textColor = [UIColor blackColor];
        self.border.backgroundColor = self.borderColor.CGColor;
    } else {
        self.textColor = self.borderColor;
        self.border.backgroundColor = self.borderColor.CGColor;
    }
}

-(void)setEnabledField:(BOOL)enabledField {
    self.enabled = enabledField;
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
    if (![NSString GRIsNullOrEmpty:textField.text]) {
        [self setColorsOfField];
    }
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
    [self setError:[NSString GRIsNullOrEmpty:textField.text]];
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

    if(![NSString GRIsNullOrEmpty:textField.text] && (self.errorLabel && !self.errorLabel.isHidden)) {
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

#pragma mark - Overriden Methods
-(CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.textInsets.x, self.textInsets.y);
}

-(CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.textInsets.x, self.textInsets.y);
}

#pragma mark -
#pragma mark - GRTextField Methods
-(void)setColorsOfField {
    UIColor * color;
    CGFloat height;
    if (self.isValid) {
        if (self.isFirstResponder) {
            color = self.selectedBorderColor;
        } else {
            color = self.borderColor;
        }
        height = 1;
    } else {
        color = self.errorBorderColor;
        height = 2;
    }
    self.errorLabel.textColor = color;
    self.border.backgroundColor = color.CGColor;
    self.border.frame = ({
        CGRect frame = self.border.frame;
        frame.size.height = height;
        frame;
    });
}

- (void)resizeErrorLabelToFit {
    if (self.errorLabel) {
        CGRect frame = ({
            CGRect frame = self.frame;
            frame.size.height = CGFLOAT_MAX;
            frame;
        });
        CGRect bounds = [self.errorLabel textRectForBounds:frame limitedToNumberOfLines:0];
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
    self.isValid = [NSString GRIsNullOrEmpty:message];
    if (!self.isValid) {
        self.errorLabel.text = message;
    } else {
        self.errorLabel.text = self.hintText;
    }
}

- (void)drawRect:(CGRect)rect {
    [self updateTextField:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(rect), CGRectGetHeight(rect))];
}


@end
