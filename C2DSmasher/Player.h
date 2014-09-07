//
//  Player.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/15/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SmasherTypes.h"
#import "MoveController.h"
#import "ControlTouchDelegate.h"

@interface Player : CCNode <ControlTouchDelegate> {
    BOOL isMove;
    MoveController *moveController;
    NSMutableDictionary *ships;
}

@property (nonatomic, retain) NSMutableDictionary *ships;

- (void)controlStop;

- (void)controlStart;

+ (Player *)player;

@end
