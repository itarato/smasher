//
//  AimCross.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/19/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MoveController.h"

@interface AimCross : CCSprite {
    BOOL isOn;
    MoveController *moveController;
}

- (void)show;

- (void)hide;

+ (AimCross *)sharedAimCross;

@end
