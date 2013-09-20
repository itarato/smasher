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

@interface Player : CCSprite {
    BOOL isMove;
    MoveController *moveController;
}

- (void)controlStop;

- (void)controlStart;

+ (Player *)player;

@end
