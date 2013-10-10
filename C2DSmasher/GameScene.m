//
//  GameScene.m
//  C2DSmasher
//
//  Created by Peter Arato on 10/8/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "GameScene.h"
#import "GameScreen.h"

@implementation GameScene

- (void)dealloc {
    //[self->gameScreen release];
    NSLog(@"DEALLOC GAME SCENE");
    [super dealloc];
}

- (id)init {
    if ((self = [super init])) {
        self->gameScreen = [GameScreen node];
        [self addChild:self->gameScreen];
    }
    return self;
}

@end
