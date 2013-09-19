//
//  MainScreen.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/10/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "MainScreen.h"
#import "GameScreen.h"

@implementation MainScreen

-(id) init {
    self = [super init];
    if (self) {
        
        CCMenuItem* startMenuItem = [CCMenuItemFont itemWithString:@"Start" block:^(id sender) {
            CCScene* gameScene = [GameScreen scene];
            [[CCDirector sharedDirector] pushScene:gameScene];
        }];
        CGSize win_size = [[CCDirector sharedDirector] winSize];
        
        CCMenu* menu = [CCMenu menuWithItems:startMenuItem, nil];
        
        [menu setPosition:CGPointMake(win_size.width * 0.5f, win_size.height * 0.5f)];
        [self addChild:menu];
    }
    return self;
}

+(CCScene *) scene {
    CCScene* scene = [CCScene node];
    CCLayer* layer = [MainScreen node];
    [scene addChild:layer z:0 tag:1];
    return scene;
}

@end
