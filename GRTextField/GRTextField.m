//
//  GRTextField.m
//  ole-consignado
//
//  Created by Guilherme on 7/25/17.
//  Copyright © 2017 Zup IT. All rights reserved.
//

#import "GRTextField.h"
#import "NSString+Extension.h"

@interface GRTextField()
@property (nonatomic, strong) id<UITextFieldDelegate> extension;
@property (nonatomic, strong) CALayer *border;
@end

@implementation GRTextField
@synthesize border = _border;

NSString *const selectionRangeKey = @"selectionRange";
-(void)awakeFromNib {
    [super awakeFromNib];
    [super setDelegate:self];
    if (self.hasBorder) {
        self.borderStyle = UITextBorderStyleNone;
    }
    
    if (self.maskPattern) {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (self.errorLabel) {
        [self.errorLabel setHidden:YES];
        self.errorLabel.textColor = [UIColor redColor];
        
        self.errorLabel.numberOfLines = 0;
        self.errorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
}

#pragma mark - Getters and Setters
-(void)setDelegate:(id<UITextFieldDelegate>)delegate {
    self.extension = delegate;
}

-(void)setMaskPattern:(NSString *)maskPattern {
    _maskPattern = maskPattern;
}

-(void)setBorder:(CALayer *)border {
    _border = border;
}

-(CALayer *)border {
    if (!_border) {
        _border = [CALayer new];
        _border.backgroundColor = [UIColor lightGrayColor].CGColor;
        _border.frame = ({
            CGRect frame = _border.frame;
            frame.origin = CGPointMake(self.bounds.origin.x, CGRectGetMaxY(self.bounds) - 1);
            frame.size = CGSizeMake(self.bounds.size.width, CGRectGetMaxY(self.bounds) - 1);
            frame;
        });
    }
    return _border;
}

#pragma mark - UITextFieldDelegate implementations

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.extension respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.extension textFieldShouldBeginEditing:textField];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.extension respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.extension textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.extension respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.extension textFieldShouldEndEditing:textField];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.extension respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.extension textFieldDidEndEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0) {
    if ([self.extension respondsToSelector:@selector(textFieldDidEndEditing:reason:)]) {
        [self.extension textFieldDidEndEditing:textField reason:reason];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.extension respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] &&
        ![self.extension textField:textField shouldChangeCharactersInRange:range replacementString:string]) {
        return NO;
    }
    
    if (self.maskPattern) {
        NSString *mutableString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        textField.text = [mutableString maskWithPattern:self.maskPattern];
        
        if(![NSString isNullOrEmpty:textField.text] && (self.errorLabel && !self.errorLabel.isHidden)) {
            [self setError:NO];
        }
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



#pragma mark - GRTextField Methods

- (void)bottomBorder {
    [self.layer addSublayer:self.border];
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
        // Check if there is a localized string for the specified key, otherwise use the key itself
        NSString *error = [self.errorMessageKey localized];
        if (!error) {
            error = self.errorMessageKey;
        }
        self.errorLabel.text = error;
        [self resizeErrorLabelToFit];
        
        self.border.backgroundColor = [UIColor redColor].CGColor;
        self.border.frame = ({
            CGRect frame = self.border.frame;
            frame.size.height = 2;
            frame;
        });
    } else {
        self.border.backgroundColor = [UIColor lightGrayColor].CGColor;
        self.border.frame = ({
            CGRect frame = self.border.frame;
            frame.size.height = 1;
            frame;
        });
    }
    [self.errorLabel setHidden:!visible];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (_hasBorder) {
        [self bottomBorder];
    }
}

@end
