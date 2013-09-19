//
//  Player.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/15/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "Player.h"
#import "JPSDK.h"

#define kPlayerSpeed 20.0f

@implementation Player

- (id)initWithFile:(NSString *)filename {
    self = [super initWithFile:filename];
    if (self) {
        [[JPManager sharedManager] addListener:self];
        [self scheduleUpdate];
        self->keyDownStack = 0;
        
        self->moveController = [[MoveController alloc] initWithSubject:self andSpeed:kPlayerSpeed];
    }
    return self;
}

- (void)update:(ccTime)delta {
    [self->moveController update];
}

+ (Player *)player {
    return [Player spriteWithFile:@"player.png"];
}

@end
