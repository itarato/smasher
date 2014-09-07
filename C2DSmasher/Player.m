//
//  Player.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/15/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "Player.h"
#import "Controller.h"
#import "SmasherTypes.h"

#define kPlayerSpeed 20.0f
#define kPlayerShipLeft @"left"
#define kPlayerShipRight @"right"
#define kPlayerShipNormal @"normal"

@interface Player ()

- (void)turnShip:(NSString *)direction;

@end

@implementation Player

@synthesize ships;

- (id)init {
    self = [super init];
    if (self) {
        [self scheduleUpdate];
        
        self->moveController = [[MoveController alloc] initWithSubject:self andSpeed:kPlayerSpeed];
        
        self->isMove = YES;
        
        CCSprite *shipLeft = [CCSprite spriteWithFile:@"playerLeft.png"];
        CCSprite *shipRight = [CCSprite spriteWithFile:@"playerRight.png"];
        CCSprite *shipNormal = [CCSprite spriteWithFile:@"player.png"];
        [self addChild:shipLeft];
        [self addChild:shipRight];
        [self addChild:shipNormal];
        [shipRight setVisible:NO];
        [shipLeft setVisible:NO];
        self.ships = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       shipLeft, kPlayerShipLeft,
                       shipRight, kPlayerShipRight,
                       shipNormal, kPlayerShipNormal, nil];
        
        [[Controller sharedController] addListener:self];
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

- (void)turnShip:(NSString *)direction {
    [[self->ships objectForKey:kPlayerShipLeft] setVisible:NO];
    [[self->ships objectForKey:kPlayerShipRight] setVisible:NO];
    [[self->ships objectForKey:kPlayerShipNormal] setVisible:NO];
    [[self->ships objectForKey:direction] setVisible:YES];
}

- (void)dealloc {
    NSLog(@"Player dealloc");
    [[Controller sharedController] removeListener:self];
    [self->ships release];
    [super dealloc];
}

#pragma mark - Controller

- (void)controlTouchBegan:(ControlBtn)buttonType {
    switch (buttonType) {
        case kControlBtnUp:
            [self turnShip:kPlayerShipLeft];
            break;
            
        case kControlBtnDown:
            [self turnShip:kPlayerShipRight];
            break;
            
        default:
            break;
    }
}

- (void)controlTouchEnd:(ControlBtn)buttonType {
    switch (buttonType) {
        case kControlBtnUp:
        case kControlBtnDown:
            [self turnShip:kPlayerShipNormal];
            break;
            
        default:
            break;
    }
}

#pragma mark - Statics

+ (Player *)player {
    return [Player node];
}

@end
