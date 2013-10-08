//
//  Controller.h
//  C2DSmasher
//
//  Created by Peter Arato on 10/1/13.
//  Copyright (c) 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ControlTouchDelegate.h"
#import "JPSDK.h"
#import "ControlTouchDelegate.h"

@interface Controller : NSObject <JPDeviceDelegate, ControlTouchDelegate> {
    NSMutableSet<ControlTouchDelegate> *delegates;
    float prevAccZ;
}

- (void)addListener:(id<ControlTouchDelegate>)delegate;
- (void)removeListener:(id<ControlTouchDelegate>)delegate;

+ (Controller *)sharedController;

@end
