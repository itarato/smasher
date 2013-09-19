//
//  Player.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/15/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "JPSDK.h"
#import "SmasherTypes.h"
#import "MoveController.h"

@interface Player : CCSprite <JPManagerDelegate, JPDeviceDelegate> {
    SpeedDirection speedX;
    SpeedDirection speedY;
    int keyDownStack;
    MoveController *moveController;
}

+ (Player *)player;

@end
