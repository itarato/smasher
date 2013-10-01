//
//  ControlTouchDelegate.h
//  C2DSmasher
//
//  Created by Peter Arato on 10/1/13.
//  Copyright (c) 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmasherTypes.h"

@protocol ControlTouchDelegate <NSObject>

@optional

- (void)controlTouchBegan:(ControlBtn)buttonType;

- (void)controlTouchEnd:(ControlBtn)buttonType;

@end
