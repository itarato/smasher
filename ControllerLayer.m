//
//  ControllerLayer.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/22/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "ControllerLayer.h"
#import "SimpleControlButton.h"

@implementation ControllerLayer

@synthesize delegate;

- (id)init {
    if ((self = [super init])) {
        CGSize win_size = [CCDirector sharedDirector].winSize;
        
        self->leftBtn = [SimpleControlButton simpleControlButtonWithImage:@"button.png" type:kControlBtnLeft];
        [self->leftBtn setPosition:ccp(50.0f, 150.0f)];
        
        self->rightBtn = [SimpleControlButton simpleControlButtonWithImage:@"button.png" type:kControlBtnRight];
        [self->rightBtn setPosition:ccp(250.0f, 150.0f)];
        
        self->upBtn = [SimpleControlButton simpleControlButtonWithImage:@"button.png" type:kControlBtnUp];
        [self->upBtn setPosition:ccp(150.0f, 250.0f)];
        
        self->downBtn = [SimpleControlButton simpleControlButtonWithImage:@"button.png" type:kControlBtnDown];
        [self->downBtn setPosition:ccp(150.0f, 50.0f)];
        
        self->aBtn = [SimpleControlButton simpleControlButtonWithImage:@"button.png" type:kControlBtnA];
        [self->aBtn setPosition:ccp(win_size.width - 100.0f, 100.0f)];
        
        self->bBtn = [SimpleControlButton simpleControlButtonWithImage:@"button.png" type:kControlBtnB];
        [self->bBtn setPosition:ccp(50.0f, 350.0f)];
        
        self->leftBtn.delegate = self;
        self->rightBtn.delegate = self;
        self->upBtn.delegate = self;
        self->downBtn.delegate = self;
        self->aBtn.delegate = self;
        self->bBtn.delegate = self;
        
        CCMenu *menu = [CCMenu menuWithItems:
                        self->leftBtn,
                        self->rightBtn,
                        self->upBtn,
                        self->downBtn,
                        self->aBtn,
                        self->bBtn,
                        nil];
        [self addChild:menu];
        menu.position = ccp(0.0f, 0.0f);
    }
    
    return self;
}

- (void)dealloc {
    [self->leftBtn release];
    [self->rightBtn release];
    [self->upBtn release];
    [self->downBtn release];
    [self->aBtn release];
    [self->bBtn release];
    
    [super dealloc];
}

#pragma mark - Controller delegate

- (void)controlTouchBegan:(ControlBtn)buttonType {    if (self->delegate != nil && [self->delegate respondsToSelector:@selector(controlTouchBegan:)]) {
        [self->delegate controlTouchBegan:buttonType];
    }
}

- (void)controlTouchEnd:(ControlBtn)buttonType {
    if (self->delegate != nil && [self->delegate respondsToSelector:@selector(controlTouchEnd:)]) {
        [self->delegate controlTouchEnd:buttonType];
    }
}

#pragma mark - Statics

+ (ControllerLayer *)sharedController {
    static ControllerLayer *instance = nil;
    
    if (instance == nil) {
        instance = [ControllerLayer node];
    }
    
    return instance;
}

@end
