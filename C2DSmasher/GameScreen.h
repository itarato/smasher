//
//  GameScreen.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/10/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "FlyingItemDelegate.h"
#import "JPSDK.h"
#import "Player.h"
#import "AimCross.h"
#import "ControllerLayer.h"
#import "ControlTouchDelegate.h"

@interface GameScreen : CCLayer <JPDeviceDelegate, JPManagerDelegate, FlyingItemDelegate, ControlTouchDelegate> {
    CCLabelTTF *scoreLabel;
    int score;
    NSMutableSet *flyingItems;
    Player *player;
    AimCross *aimCross;
    GameControlState controlState;
    float prevAccZ;
    ControllerLayer *controlPad;
}

- (void)updateScore;

- (void)shoot;

+ (CCScene *)scene;

+ (float)worldSpeedMultiplier;

@property (nonatomic, retain) CCLabelTTF *scoreLabel;

@end
