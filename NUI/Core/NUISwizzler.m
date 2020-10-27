//
//  NUISwizzler.m
//  NUIDemo
//
//  Created by Tom Benner on 12/9/12.
//  Copyright (c) 2012 Tom Benner. All rights reserved.
//

#import "NUISwizzler.h"

@implementation NUISwizzler

- (void)swizzleAll
{
    [self swizzle:[UIBarButtonItem class] fromMethodName:@"didMoveToWindow" toMethodName:nil];
    [self swizzle:[UIButton class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UIButton_didMoveToWindow))];
    [self swizzle:[UILabel class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UILabel_didMoveToWindow))];
    [self swizzle:[UINavigationBar class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UINavigationBar_didMoveToWindow))];
    [self swizzle:[UINavigationItem class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UINavigationItem_didMoveToWindow))];
    [self swizzle:[UIProgressView class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UIProgressView_didMoveToWindow))];
    [self swizzle:[UISearchBar class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UISearchBar_didMoveToWindow))];
    [self swizzle:[UISegmentedControl class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UISegmentedControl_didMoveToWindow))];
    [self swizzle:[UISlider class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UISlider_didMoveToWindow))];
    [self swizzle:[UISwitch class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UISwitch_didMoveToWindow))];
    [self swizzle:[UITabBar class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UITabBar_didMoveToWindow))];
    [self swizzle:[UITableViewCell class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UITableViewCell_didMoveToWindow))];
    [self swizzle:[UITextField class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UITextField_didMoveToWindow))];
    [self swizzle:[UITextView class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UITextView_didMoveToWindow))];
    [self swizzle:[UIToolbar class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UIToolbar_didMoveToWindow))];
    [self swizzle:[UIControl class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UIControl_didMoveToWindow))];
    [self swizzle:[UIView class] fromMethodName:@"didMoveToWindow" toMethodName:NSStringFromSelector(@selector(override_UIView_didMoveToWindow))];

    [self swizzle:[UITextField class] fromMethodName:@"textRectForBounds:" toMethodName:nil];
    [self swizzle:[UITextField class] fromMethodName:@"editingRectForBounds:" toMethodName:nil];
    [self swizzle:[UIWindow class] fromMethodName:@"becomeKeyWindow" toMethodName:nil];

    [self swizzle:[UILabel class] fromMethodName:@"setText:" toMethodName:nil];
    [self swizzle:[UIButton class] fromMethodName:@"setTitle:forState:" toMethodName:nil];

    if ((NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_6_0))
    {
        [self swizzle:[UILabel class] fromMethodName:@"setAttributedText:" toMethodName:nil];
        [self swizzle:[UIButton class] fromMethodName:@"setAttributedTitle:forState:" toMethodName:nil];
    }

    [self swizzle:[UINavigationBar class] fromMethodName:@"dealloc" toMethodName:NSStringFromSelector(@selector(override_UINavigationBar_dealloc))];
    [self swizzle:[UITabBar class] fromMethodName:@"dealloc" toMethodName:NSStringFromSelector(@selector(override_UITabBar_dealloc))];
    [self swizzle:[UITableViewCell class] fromMethodName:@"dealloc" toMethodName:NSStringFromSelector(@selector(override_UITableViewCell_dealloc))];
    [self swizzle:[UITableView class] fromMethodName:@"dealloc" toMethodName:NSStringFromSelector(@selector(override_UITableView_dealloc))];
}

- (void)swizzle:(Class)class fromMethodName:(NSString *)fromMethodName toMethodName:(NSString *)toMethodName
{
    SEL originalMethod = NSSelectorFromString(fromMethodName);
    SEL newMethod;
    if (toMethodName == nil)
        newMethod = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"override_", fromMethodName]);
    else
        newMethod = NSSelectorFromString(toMethodName);
    [self swizzle:class from:originalMethod to:newMethod];
}

- (void)swizzle:(Class)class from:(SEL)original to:(SEL)new
{
    Method originalMethod = class_getInstanceMethod(class, original);
    Method newMethod = class_getInstanceMethod(class, new);
    if (class_addMethod(class, original, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(class, new, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

@end
