//
//  MainScreen.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/10/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ControlTouchDelegate.h"

//@class GameScene;

@interface MainScreen : CCLayer <ControlTouchDelegate> {
//    GameScene *gameScene;
}

+ (CCScene *)scene;

@end
