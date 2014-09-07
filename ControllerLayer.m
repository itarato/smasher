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
        
        self->leftBtn = [SimpleControlButton simpleControlButtonWithImage:@"btn_left.png" type:kControlBtnLeft];
        [self->leftBtn setPosition:ccp(50.0f, 150.0f)];
        
        self->rightBtn = [SimpleControlButton simpleControlButtonWithImage:@"btn_right.png" type:kControlBtnRight];
        [self->rightBtn setPosition:ccp(250.0f, 150.0f)];
        
        self->upBtn = [SimpleControlButton simpleControlButtonWithImage:@"btn_up.png" type:kControlBtnUp];
        [self->upBtn setPosition:ccp(150.0f, 250.0f)];
        
        self->downBtn = [SimpleControlButton simpleControlButtonWithImage:@"btn_down.png" type:kControlBtnDown];
        [self->downBtn setPosition:ccp(150.0f, 50.0f)];
        
        self->aBtn = [SimpleControlButton simpleControlButtonWithImage:@"btn_a.png" type:kControlBtnA];
        [self->aBtn setPosition:ccp(win_size.width - 100.0f, 100.0f)];
        
        self->bBtn = [SimpleControlButton simpleControlButtonWithImage:@"btn_b.png" type:kControlBtnB];
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
    NSLog(@"DEALLOC %s", __FILE__);
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

+ (ControllerLayer *)sharedControllerWithDelegate:(id<ControlTouchDelegate>)delegate {
    static ControllerLayer *_controllerLayerInstance = nil;
    
    if (_controllerLayerInstance == nil) {
        _controllerLayerInstance = [ControllerLayer node];
        _controllerLayerInstance.delegate = delegate;
        [_controllerLayerInstance retain];
    }
    
    return _controllerLayerInstance;
}

@end
