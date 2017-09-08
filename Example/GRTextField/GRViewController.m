//
//  GRViewController.m
//  GRTextField
//
//  Created by guilherme.hor@gmail.com on 08/30/2017.
//  Copyright (c) 2017 guilherme.hor@gmail.com. All rights reserved.
//

#import "GRViewController.h"
#import <GRTextField/GRTextField.h>

@interface GRViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet GRTextField *textField;
@end

@implementation GRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.text = @"Text";
    self.textField.errorFont = [UIFont systemFontOfSize:10];
}

#pragma mark -
#pragma mark - Methods
-(void)validate {
    [self.textField setError:(self.textField.text.length < 1)];
}

#pragma mark -
#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self validate];
}

#pragma mark -
#pragma mark - IBActions
- (IBAction)validateAction:(id)sender {
    [self validate];
}

- (IBAction)tapGestureOnViewAction:(id)sender {
    [self.view endEditing:YES];
}

@end
