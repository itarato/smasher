//
//  GameScreen.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/10/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "GameScreen.h"
#import "Player.h"
#import "JPSDK.h"
#import "FlyingItem.h"
#import "FoodItem.h"
#import "EnemyItem.h"
#import "ShootPath.h"
#import "Controller.h"

#define kGameFlyingItemHitDistance 60.0f
#define kGameSpeedSlow 0.3f
#define kGameSpeedNormal 1.0f
#define kGameMaxHealth 5
#define kGameMaxLives 1

float gameSpeedModifier = kGameSpeedNormal;


@interface GameScreen ()

- (void)findEnemyforPosition:(CGPoint)point;

- (void)startRound;

- (void)endGame;

@end


@implementation GameScreen

@synthesize scoreLabel;

- (void)setupLabels {
    CGSize win_size = [[CCDirector sharedDirector] winSize];
    
    // Labels.
    self->scoreLabel = [CCLabelTTF labelWithString:@"" fontName:@"Helvetica" fontSize:30.0f];
    [self->scoreLabel setPosition:ccp(win_size.width - 200.0f, win_size.height - 100.0f)];
    [self->gameLayer addChild:self->scoreLabel];
    
    self->healthLabel = [CCLabelTTF labelWithString:@"" fontName:@"Helvetica" fontSize:30.0f];
    [self->healthLabel setPosition:ccp(win_size.width - 200.0f, win_size.height - 140.0f)];
    [self->gameLayer addChild:self->healthLabel];
    
    self->livesLabel = [CCLabelTTF labelWithString:@"" fontName:@"Helvetica" fontSize:30.0f];
    [self->livesLabel setPosition:ccp(win_size.width - 200.0f, win_size.height - 180.0f)];
    [self->gameLayer addChild:self->livesLabel];
}

- (id)init {
    self = [super init];
    if (self) {
        CGSize win_size = [[CCDirector sharedDirector] winSize];
        
        self->gameLayer = [CCNode node];
        self->controlLayer = [CCNode node];
        [self addChild:gameLayer];
        [self addChild:controlLayer];
        
        self->player = [Player player];
        [self->gameLayer addChild:self->player];
        [self->player setPosition:CGPointMake(100.0f, win_size.height * 0.5)];
        
        [self setupLabels];
        
        self->flyingItems = [[NSMutableSet alloc] init];
     
        self->aimCross = [AimCross sharedAimCross];
        [self->gameLayer addChild:self->aimCross];
        
        self->controlState = kGameControlStatePlayerControl;
        
        self->prevAccZ = 0.0f;
        
        // Visual control pad.
        self->controlPad = [ControllerLayer sharedController];
        self->controlPad.delegate = [Controller sharedController];
        [self->controlLayer addChild:self->controlPad];

        if ([JPManager sharedManager].devicesCount > 0) {
            [self->controlLayer setVisible:NO];
        }
        
        self->score = 0;
        self->lives = kGameMaxLives;
        
        [self scheduleUpdate];
        
        [self startRound];
    }
    return self;
}

- (void)clearDisplay {
    NSSet *_items = [NSSet setWithSet:self->flyingItems];
    for (FlyingItem *item in _items) {
        [item die:kFlyingItemClearDisplay];
    }
}

- (void)startRound {
    self->health = kGameMaxHealth;
    [self clearDisplay];
}

- (void)endGame {
    [self clearDisplay];
    [[CCDirector sharedDirector] popScene];
}

- (void)update:(ccTime)delta {
    if (CCRANDOM_0_1() < 0.05f) {
        FlyingItemType type;
        float rand = CCRANDOM_0_1();
        
        if (rand < 0.3) {
            type = kFlyingItemFood;
        }
        else {
            type = kFlyingItemEnemy;
        }
        
        FlyingItem *item = [FlyingItem flyingItemOfType:type];
        item.delegate = self;
        [self->gameLayer addChild:item];
        [self->flyingItems addObject:item];
    }
    
    [self findEnemyforPosition:self->player.position];
}

- (void)onEnter {
    // Attach Controller delegate to self.
    [[Controller sharedController] addListener:self];
    
    // Attach Joypad to the Controller.
    [[JPManager sharedManager] addListener:self];
    [super onEnter];
}

- (void)onExit {
    [[Controller sharedController] removeListener:self];
    [[JPManager sharedManager] removeListener:self];
    [super onExit];
}

- (void)findEnemyforPosition:(CGPoint)point {
    NSSet *_items = [NSSet setWithSet:self->flyingItems];
    for (id item in _items) {
        if (ccpDistance(point, ((FlyingItem *)item).position) < kGameFlyingItemHitDistance) {
            [((FlyingItem *) item) die:kFlyingItemPlayerHit];
        }
    }
}

- (void)flyingItemDied:(FlyingItem *)item withType:(FlyingItemDeathType)deathType {
    if (deathType == kFlyingItemClearDisplay) {
        return;
    }
    
    if (deathType == kFlyingItemPlayerHit) {
        if ([item isKindOfClass:[FoodItem class]]) {
            self->score++;
        }
        
        if ([item isKindOfClass:[EnemyItem class]]) {
            self->score -= 5;
            self->health -= 5;
        }
    }
    
    if (self->health <= 0) {
        self->lives--;
        self->health = kGameMaxHealth;
        [self startRound];
    }
    if (self->lives <= 0) {
        [self endGame];
    }
    
    [self updateScore];
    [self->flyingItems removeObject:item];
}

- (void)updateScore {
    [self->scoreLabel setString:[NSString stringWithFormat:@"Score: %d", self->score]];
    [self->healthLabel setString:[NSString stringWithFormat:@"Health: %d", self->health]];
    [self->livesLabel setString:[NSString stringWithFormat:@"Lives: %d", self->lives]];
}

- (void)shoot {
    if (!self->controlState == kGameControlStateAimControl) {
        return;
    }
    
    [self findEnemyforPosition:self->aimCross.position];
    
    ShootPath *shootPath = [ShootPath shootPathFrom:self->player.position to:self->aimCross.position];
    [self addChild:shootPath];
}

- (void)dealloc {
////    [self->scoreLabel release];
////    [self->flyingItems release];
////    [self->player release];
////    [self->aimCross release];
////    [self->controlPad release];
////    [self->controlLayer release];
////    [self->gameLayer release];
//    
    [super dealloc];
}

#pragma mark - Controller delegate

- (void)controlTouchBegan:(ControlBtn)buttonType {
    switch (buttonType) {
        case kControlBtnA:
            gameSpeedModifier = kGameSpeedSlow;
            self->controlState = kGameControlStateAimControl;
            [self->player controlStop];
            [self->aimCross show];
            break;
            
        case kControlBtnB:
            [self shoot];
            break;
            
        case kControlBtnZShake:
            [self shoot];
            break;
            
        default:
            break;
    }
}

- (void)controlTouchEnd:(ControlBtn)buttonType {
    switch (buttonType) {
        case kControlBtnA:
            gameSpeedModifier = kGameSpeedNormal;
            self->controlState = kGameControlStatePlayerControl;
            [self->player controlStart];
            [self->aimCross hide];
            break;
            
        default:
            break;
    }
}

#pragma mark - Joypad

- (void)joypadManager:(JPManager *)manager deviceDidConnect:(JPDevice *)device {
    [self->controlLayer setVisible:NO];
}

- (void)joypadManager:(JPManager *)manager deviceDidDisconnect:(JPDevice *)device {
    [self->controlLayer setVisible:YES];
}

#pragma mark - Statics

+ (CCScene *)scene {
    static CCScene *instance;
    
    if (instance == nil) {
        instance = [CCScene node];
        CCLayer* layer = [GameScreen node];
        [instance addChild:layer];
    }
    
    return instance;
}

+ (float)worldSpeedMultiplier {
    return gameSpeedModifier;
}

@end
