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

//- (id)init {
//    if ((self = [super init])) {
////        [self setTouchEnabled:YES];
//    }
//    return self;
//}

#ifdef __CC_PLATFORM_IOS
//- (void)registerWithTouchDispatcher {
//	CCDirector *director = [CCDirector sharedDirector];
//	[[director touchDispatcher] addTargetedDelegate:self priority:kCCMenuHandlerPriority swallowsTouches:YES];
//}
#endif

//- (BOOL)reg

//
//- (void) onEnterTransitionDidFinish
//{
//	[[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:1 swallowsTouches:YES];
//}
//
//- (void) onExit
//{
//	[[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
//}

////- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
//- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"Rabbit.");
//    if (self->delegate != nil && [self->delegate respondsToSelector:@selector(controlTouchBegan:)]) {
//        [self->delegate controlTouchBegan:self->btnType];
//    }
////    return YES;
//}
//
//- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    if (self->delegate != nil && [self->delegate respondsToSelector:@selector(controlTouchEnd:)]) {
//        [self->delegate controlTouchEnd:self->btnType];
//    }
//}

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
