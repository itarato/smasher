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

@interface MainScreen : CCLayer <ControlTouchDelegate> {
    CCScene *gameScene;
}

+ (CCScene *)scene;

@end
