//
//  SimpleControlButton.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/22/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SmasherTypes.h"
#import "ControlTouchDelegate.h"

@interface SimpleControlButton : CCMenuItemImage {
    ControlBtn btnType;
    id<ControlTouchDelegate> delegate;
}

@property (nonatomic, assign) id<ControlTouchDelegate> delegate;

+ (SimpleControlButton *)simpleControlButtonWithImage:(NSString *)imageName type:(ControlBtn)btnType;

@end
