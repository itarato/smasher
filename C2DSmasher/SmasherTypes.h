//
//  SmasherTypes.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/16/13.
//  Copyright (c) 2013 Peter Arato. All rights reserved.
//

typedef enum {
    kFlyingItemCloud,
    kFlyingItemEnemy,
    kFlyingItemFood
} FlyingItemType;

typedef enum {
    kFlyingItemOutOufScreen,
    kFlyingItemPlayerHit,
    kFlyingItemClearDisplay
} FlyingItemDeathType;

typedef enum {
    kPlayerSpeedNeg  = -1,
    kPlayerSpeedNull = 0,
    kPlayerSpeedPos  = 1
} SpeedDirection;

typedef enum {
    kGameControlStatePlayerControl,
    kGameControlStateAimControl
} GameControlState;

typedef enum {
    kControlBtnUp,
    kControlBtnDown,
    kControlBtnLeft,
    kControlBtnRight,
    kControlBtnA,
    kControlBtnB,
    kControlBtnZShake
} ControlBtn;
