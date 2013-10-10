//
//  MainScreen.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/10/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "MainScreen.h"
#import "GameScreen.h"
#import "Controller.h"

@interface MainScreen ()

- (void)startGame;

@end

@implementation MainScreen

- (id)init {
    self = [super init];
    if (self) {
        
        CCMenuItem *startMenuItem = [CCMenuItemFont itemWithString:@"Start" target:self selector:@selector(startGame)];
        CGSize win_size = [[CCDirector sharedDirector] winSize];
        
        CCMenu* menu = [CCMenu menuWithItems:startMenuItem, nil];
        
        [menu setPosition:CGPointMake(win_size.width * 0.5f, win_size.height * 0.5f)];
        [self addChild:menu];
    }
    return self;
}

- (void)startGame {
//    if (self->gameScene == nil) {
//        self->gameScene = [GameScene node];
//    }
    CCScene *gameScene = [GameScreen scene];
    [[CCDirector sharedDirector] pushScene:gameScene];
}

#pragma mark - CCNode methods

- (void)onEnter {
    [[Controller sharedController] addListener:self];
    [super onEnter];
}

- (void)onExit {
    [[Controller sharedController] removeListener:self];
    [super onExit];
}

#pragma mark - Controller delegate

- (void)controlTouchEnd:(ControlBtn)buttonType {
    switch (buttonType) {
        case kControlBtnA:
        case kControlBtnB:
            [self startGame];
            break;
            
        default:
            break;
    }
}

#pragma mark - Statics

+ (CCScene *)scene {
    CCScene* scene = [CCScene node];
    CCLayer* layer = [MainScreen node];
    [scene addChild:layer z:0 tag:1];
    return scene;
}

@end
