//
//  Background.m
//  C2DSmasher
//
//  Created by Peter Arato on 10/15/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "Background.h"
#import "GameScreen.h"

#define kBackgroundOffsetStep 8.0f
#define kBackgroundOverlayOffsetStep 12.0f

#define kBackgroundTileWidth 128.0f
#define kBackgroundOverlayTileWidth 256.0f

@implementation Background

- (id)init {
    if ((self = [super init])) {
        CGSize win_size = [CCDirector sharedDirector].winSize;
        ccTexParams bgrTextureParams = {GL_LINEAR, GL_LINEAR, GL_REPEAT, GL_REPEAT};
        
        self->mainBgr = [CCSprite spriteWithFile:@"starBackgroundSmall.png" rect:CGRectMake(0.0f, 0.0f, win_size.width + kBackgroundTileWidth, win_size.height)];
        [self->mainBgr.texture setTexParameters:&bgrTextureParams];
        [self->mainBgr setPosition:ccp((win_size.width + kBackgroundTileWidth) * 0.5, win_size.height * 0.5)];
        [self addChild:self->mainBgr];
        
        self->overlayBgr = [CCSprite spriteWithFile:@"starBackgroundOverlay.png" rect:CGRectMake(0.0f, 0.0f, win_size.width + kBackgroundOverlayTileWidth, win_size.height)];
        [self->overlayBgr.texture setTexParameters:&bgrTextureParams];
        [self->overlayBgr setPosition:ccp((win_size.width + kBackgroundOverlayTileWidth) * 0.5, win_size.height * 0.5)];
        [self addChild:self->overlayBgr];
        
        self->mainBgrOffset = 0.0f;
        self->overlayBgrOffset = 0.0f;
        
        [self scheduleUpdate];
    }
    return self;
}

- (void)update:(ccTime)delta {
    self->mainBgrOffset += kBackgroundOffsetStep * [GameScreen worldSpeedMultiplier];
    self->overlayBgrOffset += kBackgroundOverlayOffsetStep * [GameScreen worldSpeedMultiplier];
    if (self->mainBgrOffset > kBackgroundTileWidth) {
        self->mainBgrOffset = 0.0f;
    }
    if (self->overlayBgrOffset > kBackgroundOverlayTileWidth) {
        self->overlayBgrOffset = 0.0f;
    }
    CGSize win_size = [CCDirector sharedDirector].winSize;
    [self->mainBgr setPosition:ccp((win_size.width + kBackgroundTileWidth) * 0.5 - self->mainBgrOffset, self->mainBgr.position.y)];
    [self->overlayBgr setPosition:ccp((win_size.width + kBackgroundOverlayTileWidth) * 0.5 - self->overlayBgrOffset, self->overlayBgr.position.y)];
}

@end
