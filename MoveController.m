//
//  MoveController.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/19/13.
//  Copyright (c) 2013 Peter Arato. All rights reserved.
//

#import "MoveController.h"

@implementation MoveController

- (id)initWithSubject:(CCNode *)subjectNode andSpeed:(float)speed {
    if ((self = [super init])) {
        self->keyDownStack = 0;
        self->defaultSpeed = speed;
        self->subject = subjectNode;
        
        [[JPManager sharedManager] addListener:self];
    }
    return self;
}

- (void)update {
    if (self->keyDownStack) {
        float _speedX = self->defaultSpeed * self->speedX;
        float _speedY = self->defaultSpeed * self->speedY;
        
        if (!(self->speedX ^ self->speedY)) {
            _speedX /= M_SQRT2;
            _speedY /= M_SQRT2;
        }
        
        CGSize win_size = [[CCDirector sharedDirector] winSize];
        if (
            self->subject.position.x + _speedX < 0.0f ||
            self->subject.position.x + _speedX > win_size.width
            ) {
            _speedX = 0.0f;
        }
        if (
            self->subject.position.y - _speedY < 0.0f ||
            self->subject.position.y - _speedY > win_size.height
            ) {
            _speedY = 0.0f;
        }
        [self->subject setPosition:CGPointMake(self->subject.position.x + _speedX, self->subject.position.y - _speedY)];
    }
}

#pragma mark JP

- (void)joypadDevice:(JPDevice *)device dPad:(JPInputIdentifier)dpad buttonDown:(JPDpadButton)dpadButton {
    // NSLog(@"DOWN %s - %d", __FUNCTION__, dpadButton);
    self->keyDownStack++;
    switch (dpadButton) {
        case kJPDpadButtonUp:
            self->speedY = kPlayerSpeedNeg;
            break;
            
        case kJPDpadButtonDown:
            self->speedY = kPlayerSpeedPos;
            break;
            
        case kJPDpadButtonLeft:
            self->speedX = kPlayerSpeedNeg;
            break;
            
        case kJPDpadButtonRight:
            self->speedX = kPlayerSpeedPos;
            break;
            
        default:
            break;
    }
}

- (void)joypadDevice:(JPDevice *)device dPad:(JPInputIdentifier)dpad buttonUp:(JPDpadButton)dpadButton {
    // NSLog(@"UP %s - %d", __FUNCTION__, dpadButton);
    self->keyDownStack--;
    switch (dpadButton) {
        case kJPDpadButtonUp:
        case kJPDpadButtonDown:
            self->speedY = kPlayerSpeedNull;
            break;
            
        case kJPDpadButtonLeft:
        case kJPDpadButtonRight:
            self->speedX = kPlayerSpeedNull;
            break;
            
        default:
            break;
    }
}

@end
