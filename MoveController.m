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
        
        [[Controller sharedController] addListener:self];
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

#pragma mark - Controller delegate

- (void)controlTouchBegan:(ControlBtn)buttonType {
    NSLog(@"MOVE");
    self->keyDownStack++;
    switch (buttonType) {
        case kControlBtnUp:
            self->speedY = kPlayerSpeedNeg;
            break;
            
        case kControlBtnDown:
            self->speedY = kPlayerSpeedPos;
            break;
            
        case kControlBtnLeft:
            self->speedX = kPlayerSpeedNeg;
            break;
            
        case kControlBtnRight:
            self->speedX = kPlayerSpeedPos;
            break;
            
        default:
            break;
    }
}

- (void)controlTouchEnd:(ControlBtn)buttonType {
    self->keyDownStack--;
    switch (buttonType) {
        case kControlBtnUp:
        case kControlBtnDown:
            self->speedY = kPlayerSpeedNull;
            break;
            
        case kControlBtnLeft:
        case kControlBtnRight:
            self->speedX = kPlayerSpeedNull;
            break;
            
        default:
            break;
    }
}

@end
