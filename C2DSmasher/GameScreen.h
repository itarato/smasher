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

@interface GameScreen : CCLayer <JPManagerDelegate, FlyingItemDelegate, ControlTouchDelegate> {
    CCLabelTTF *scoreLabel;
    CCLabelTTF *healthLabel;
    CCLabelTTF *livesLabel;
    
    int score;
    NSMutableSet *flyingItems;
    Player *player;
    AimCross *aimCross;
    GameControlState controlState;
    float prevAccZ;
    ControllerLayer *controlPad;
    
    int health;
    int lives;
    
    CCNode *controlLayer;
    CCNode *gameLayer;
}

- (void)updateScore;

- (void)shoot;

+ (CCScene *)scene;

+ (float)worldSpeedMultiplier;

@end
