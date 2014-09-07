//
//  Background.h
//  C2DSmasher
//
//  Created by Peter Arato on 10/15/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Background : CCNode {
    CCSprite *mainBgr;
    CCSprite *overlayBgr;
    float mainBgrOffset;
    float overlayBgrOffset;
}

@end
