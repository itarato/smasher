//
//  MoveController.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/19/13.
//  Copyright (c) 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "JPSDK.h"
#import "SmasherTypes.h"

@interface MoveController : NSObject <JPDeviceDelegate> {
    int keyDownStack;
    float defaultSpeed;
    SpeedDirection speedX;
    SpeedDirection speedY;
    CCNode *subject;
}

- (id)initWithSubject:(CCNode *)subjectNode andSpeed:(float)speed;

- (void)update;

@end
