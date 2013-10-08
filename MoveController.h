//
//  MoveController.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/19/13.
//  Copyright (c) 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SmasherTypes.h"
#import "Controller.h"
#import "ControlTouchDelegate.h"

@interface MoveController : NSObject <ControlTouchDelegate> {
    int keyDownStack;
    float defaultSpeed;
    SpeedDirection speedX;
    SpeedDirection speedY;
    CCNode *subject;
}

- (id)initWithSubject:(CCNode *)subjectNode andSpeed:(float)speed;

- (void)update;

@end
