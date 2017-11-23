# GRTextField

[![CI Status](http://img.shields.io/travis/gho-ramos/GRTextField.svg?style=flat)](https://travis-ci.org/gho-ramos/GRTextField)
[![Version](https://img.shields.io/cocoapods/v/GRTextField.svg?style=flat)](http://cocoapods.org/pods/GRTextField)
[![License](https://img.shields.io/cocoapods/l/GRTextField.svg?style=flat)](http://cocoapods.org/pods/GRTextField)
[![Platform](https://img.shields.io/cocoapods/p/GRTextField.svg?style=flat)](http://cocoapods.org/pods/GRTextField)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## _Interface Builder_

Using it on GRTextField on IB is pretty straightforward, you have use it as the class (at the Identity Inspector Tab on the right panel) for the UITextField element on your storyboard.

![Field Class Image](https://github.com/gho-ramos/GRTextField/blob/master/Screenshots/FieldClass.png)

### _Error Outlet_

If you want to set a label as an output source for your error messages, you can drag the "errorLabel" item on the connections inspector

![Field Connections Inspector](https://github.com/gho-ramos/GRTextField/blob/master/Screenshots/FieldOutlets.png)

the field instance will automatically hide the label if you set it as the errorLabel outlet

### _Field Properties_

On the attributes inspector tab, you cant set the properties for the textField

![Field Properties](https://github.com/gho-ramos/GRTextField/blob/master/Screenshots/FieldOptions.png)

**_Mask Pattern_**: Will turn your field into NUMERIC ONLY and will try to match the pattern specified in this property.
e.g.: using (##) #####-#### (BR cellphone mask) as a mask will output the text as (01) 23456-7890

**_Error Message Key_**: Will either use a localizable* key specified on a string table file, word or phrase, you decide which one you want to use.

**_Has Border_**: Toggle the bottom line on the field.

**_Max Characters_**: Set a max number of characters for the field, it will work with alphanumeric characters as well, BUT only if your **_Mask Pattern_** is empty, otherwise it will prioritize the **_Mask Pattern_** property and ignore this one.

\**Unfortunately, at this time the field is only accepting strings from a string table named "localizable.strings", I'll try to change that asap.*


### _Colors_

**_Border_**: Defines the color for the bottom line when the field is not selected;

**_Error_**: Defines the color for both error label and bottom line when there's an error\*\*;

**_Selected_**: Defines the color for the bottom line when the field is selected and there's no errors;


\*\* *There's a property on the field class called '**isValid**', everytime you call the method 'setError:' passing **YES** it will set the property as **NO** the error label will appear and the bottom line will change to **redColor** (as default) or whatever the custom color you set as the error color*

## Code Usage

There's no secret mystery behind this one.

```ObjectiveC
GRTextField * textField = [[GRTextField alloc] init];
```
or
```ObjectiveC
GRTextField * textField = [GRTextField new];
```

Apart from the properties already specified here (in the upper section), there's also the documentation on [CocoaDocs](http://cocoadocs.org/docsets/GRTextField/1.0.1/Classes/GRTextField.html)

## Requirements
***ARC***

## Installation

GRTextField is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GRTextField"
```

## Author

guilherme.hor@gmail.com

## License

GRTextField is available under the MIT license. See the LICENSE file for more info.
