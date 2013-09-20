//
//  Player.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/15/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "Player.h"

#define kPlayerSpeed 20.0f

@implementation Player

- (id)initWithFile:(NSString *)filename {
    self = [super initWithFile:filename];
    if (self) {
        [self scheduleUpdate];
        
        self->moveController = [[MoveController alloc] initWithSubject:self andSpeed:kPlayerSpeed];
        
        self->isMove = YES;
    }
    return self;
}

- (void)update:(ccTime)delta {
    if (self->isMove) {
        [self->moveController update];
    }
}

- (void)controlStop {
    self->isMove = NO;
}

- (void)controlStart {
    self->isMove = YES;
}

#pragma mark - Statics

+ (Player *)player {
    return [Player spriteWithFile:@"player.png"];
}

@end
