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

- (id)init {
    if ((self = [super init])) {
        [self setTouchEnabled:YES];
    }
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self->delegate != nil && [self->delegate respondsToSelector:@selector(controlTouchBegan:)]) {
        [self->delegate controlTouchBegan:self->btnType];
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self->delegate != nil && [self->delegate respondsToSelector:@selector(controlTouchEnd:)]) {
        [self->delegate controlTouchEnd:self->btnType];
    }
}

+ (SimpleControlButton *)simpleControlButtonWithImage:(NSString *)imageName andType:(ControlBtn)btnType {
    SimpleControlButton *instance = [SimpleControlButton node];
    
    CCSprite *image = [CCSprite spriteWithFile:imageName];
    [instance addChild:image];
    
    instance->btnType = btnType;
    return instance;
}

@end
