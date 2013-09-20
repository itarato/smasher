//
//  AimCross.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/19/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "AimCross.h"

@implementation AimCross

- (id)initWithFile:(NSString *)filename {
    if ((self = [super initWithFile:filename])) {
        self->moveController = [[MoveController alloc] initWithSubject:self andSpeed:20.0f];
        [self scheduleUpdate];
    }
    return self;
}

- (void)show {
    [self setVisible:YES];
    CGSize win_size = [CCDirector sharedDirector].winSize;
    [self setPosition:ccp(win_size.width * 0.5, win_size.height * 0.5)];
}

- (void)hide {
    [self setVisible:NO];
}

- (void)update:(ccTime)delta {
    [self->moveController update];
}

#pragma mark Statics

+ (AimCross *)sharedAimCross {
    static AimCross *instance = nil;
    
    if (instance == nil) {
        instance = [AimCross spriteWithFile:@"aim_cross.png"];
        [instance hide];
    }
    
    return instance;
}

@end
