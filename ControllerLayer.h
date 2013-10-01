//
//  ControllerLayer.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/22/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleControlButton.h"
#import "ControlTouchDelegate.h"

@interface ControllerLayer : CCLayer <ControlTouchDelegate> {
    SimpleControlButton *leftBtn;
    SimpleControlButton *rightBtn;
    SimpleControlButton *upBtn;
    SimpleControlButton *downBtn;
    SimpleControlButton *aBtn;
    SimpleControlButton *bBtn;
    
    id<ControlTouchDelegate> delegate;
}

@property (nonatomic, assign) id<ControlTouchDelegate> delegate;

+ (ControllerLayer *)sharedController;

@end
