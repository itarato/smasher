//
//  SimpleControlButton.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/22/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "SimpleControlButton.h"

@implementation SimpleControlButton

@synthesize delegate;

- (void)selected {
    if (self->delegate != nil && [self->delegate respondsToSelector:@selector(controlTouchBegan:)]) {
        [self->delegate controlTouchBegan:self->btnType];
    }
}

- (void)unselected {
    if (self->delegate != nil && [self->delegate respondsToSelector:@selector(controlTouchEnd:)]) {
        [self->delegate controlTouchEnd:self->btnType];
    }
}

+ (SimpleControlButton *)simpleControlButtonWithImage:(NSString *)imageName type:(ControlBtn)btnType {
    SimpleControlButton *instance = [[SimpleControlButton alloc] initWithNormalImage:imageName selectedImage:imageName disabledImage:imageName block:nil];
    instance->btnType = btnType;
    return instance;
}

@end
