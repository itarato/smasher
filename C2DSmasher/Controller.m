//
//  Controller.m
//  C2DSmasher
//
//  Created by Peter Arato on 10/1/13.
//  Copyright (c) 2013 Peter Arato. All rights reserved.
//

#import "Controller.h"

@interface Controller ()

- (ControlBtn)controllerOfDpadButton:(JPDpadButton)button error:(BOOL *)error;

- (ControlBtn)controllerOfInputButton:(JPInputIdentifier)button error:(BOOL *)error;

- (void)notifyListenersTouchBegin:(ControlBtn)button;

- (void)notifyListenersTouchEnd:(ControlBtn)button;

@end

@implementation Controller

- (void)dealloc {
    [super dealloc];
}

- (void)addListener:(id<ControlTouchDelegate>)delegate {
    if (self->delegates == nil) {
        self->delegates = (NSMutableSet<ControlTouchDelegate> *)[[NSMutableSet alloc] init];
    }
    
    if (![self->delegates containsObject:delegate]) {
        [self->delegates addObject:delegate];
    }
}

- (void)removeListener:(id<ControlTouchDelegate>)delegate {
    if ([self->delegates containsObject:delegate]) {
        [self->delegates removeObject:delegate];
    }
}

#pragma mark - Button converters

- (ControlBtn)controllerOfDpadButton:(JPDpadButton)button error:(BOOL *)error {
    *error = NO;
    switch (button) {
        case kJPDpadButtonLeft:
            return kControlBtnLeft;
            
        case kJPDpadButtonRight:
            return kControlBtnRight;
            
        case kJPDpadButtonUp:
            return kControlBtnUp;
            
        case kJPDpadButtonDown:
            return kControlBtnDown;
            
        default:
            *error = YES;
            return 0;
    }
}

- (ControlBtn)controllerOfInputButton:(JPInputIdentifier)button error:(BOOL *)error {
    *error = NO;
    switch (button) {
        case kJPInputAButton:
            return kControlBtnA;
            
        case kJPInputBButton:
            return kControlBtnB;
            
        default:
            *error = YES;
            return 0;
    }
}

#pragma mark - Notifiers

- (void)notifyListenersTouchBegin:(ControlBtn)button {
//    NSLog(@"Notified %d about: %d", [self->delegates count], button);
    // To prevent using the original so it couldn't change.
    NSSet<ControlTouchDelegate> *listeners = (NSSet<ControlTouchDelegate> *)[NSSet setWithSet:self->delegates];
    for (id<ControlTouchDelegate> delegate in listeners) {
        if (delegate != nil && [delegate respondsToSelector:@selector(controlTouchBegan:)]) {
            [delegate controlTouchBegan:button];
        }
    }
}

- (void)notifyListenersTouchEnd:(ControlBtn)button {
    // To prevent using the original so it couldn't change.
    NSSet<ControlTouchDelegate> *listeners = (NSSet<ControlTouchDelegate> *)[NSSet setWithSet:self->delegates];
    for (id<ControlTouchDelegate> delegate in listeners) {
        if (delegate != nil && [delegate respondsToSelector:@selector(controlTouchEnd:)]) {
            [delegate controlTouchEnd:button];
        }
    }
}

#pragma mark - Control touch delegate

- (void)controlTouchBegan:(ControlBtn)buttonType {
    [self notifyListenersTouchBegin:buttonType];
}

- (void)controlTouchEnd:(ControlBtn)buttonType {
    [self notifyListenersTouchEnd:buttonType];
}

#pragma mark - Joypad delegates

- (void)joypadDevice:(JPDevice *)device dPad:(JPInputIdentifier)dpad buttonDown:(JPDpadButton)dpadButton {
    BOOL isError;
    ControlBtn controlButton = [self controllerOfDpadButton:dpadButton error:&isError];
    if (isError) {
        return;
    }
    [self notifyListenersTouchBegin:controlButton];
}

- (void)joypadDevice:(JPDevice *)device dPad:(JPInputIdentifier)dpad buttonUp:(JPDpadButton)dpadButton {
    BOOL isError;
    ControlBtn controlButton = [self controllerOfDpadButton:dpadButton error:&isError];
    if (isError) {
        return;
    }
    [self notifyListenersTouchEnd:controlButton];
}

- (void)joypadDevice:(JPDevice *)device buttonDown:(JPInputIdentifier)button {
    BOOL isError;
    ControlBtn controlButton = [self controllerOfInputButton:button error:&isError];
    if (isError) {
        return;
    }
    [self notifyListenersTouchBegin:controlButton];
}

- (void)joypadDevice:(JPDevice *)device buttonUp:(JPInputIdentifier)button {
    BOOL isError;
    ControlBtn controlButton = [self controllerOfInputButton:button error:&isError];
    if (isError) {
        return;
    }
    [self notifyListenersTouchEnd:controlButton];
}

- (void)joypadDevice:(JPDevice *)device didAccelerate:(JPAcceleration)accel {
    if (fabsf(accel.z - self->prevAccZ) > 0.15f) {
        [self notifyListenersTouchBegin:kControlBtnZShake];
    }
    self->prevAccZ = accel.z;
}

#pragma mark - Statics

+ (Controller *)sharedController {
    static Controller *instance;
    
    if (instance == nil) {
        instance = [[Controller alloc] init];
    }
    
    return instance;
}

@end
