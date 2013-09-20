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

#define kGameFlyingItemHitDistance 60.0f
#define kGameSpeedSlow 0.3f
#define kGameSpeedNormal 1.0f

float gameSpeedModifier = kGameSpeedNormal;


@interface GameScreen ()

- (void)findEnemyforPosition:(CGPoint)point;

@end


@implementation GameScreen

@synthesize scoreLabel;

-(id) init {
    self = [super init];
    if (self) {
        self->score = 0;
        
        CGSize win_size = [[CCDirector sharedDirector] winSize];
        
        self->player = [Player player];
        [self addChild:self->player];
        [self->player setPosition:CGPointMake(100.0f, win_size.height * 0.5)];
        
        self.scoreLabel = [CCLabelTTF labelWithString:@"Score: 0" fontName:@"Helvetica" fontSize:30.0f];
        [self addChild:scoreLabel];
        [scoreLabel setPosition:ccp(win_size.width - 200.0f, win_size.height - 100.0f)];
        
        self->flyingItems = [[NSMutableSet alloc] init];
        
        [[JPManager sharedManager] addListener:self];
        
        self->aimCross = [AimCross sharedAimCross];
        [self addChild:self->aimCross];
        
        self->controlState = kGameControlStatePlayerControl;
        
        [self setAccelerometerEnabled:YES];
        
        [self scheduleUpdate];
    }
    return self;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    NSLog(@"Acceleration: %@", acceleration);
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
        [self addChild:item];
        [self->flyingItems addObject:item];
    }
    
    [self findEnemyforPosition:self->player.position];
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
    if (deathType == kFlyingItemPlayerHit) {
        if ([item isKindOfClass:[FoodItem class]]) {
            self->score++;
        }
        
        if ([item isKindOfClass:[EnemyItem class]]) {
            self->score -= 5;
        }
    }
    
    [self updateScore];
    [self->flyingItems removeObject:item];
}

- (void)updateScore {
    [self.scoreLabel setString:[NSString stringWithFormat:@"Score: %d", self->score]];
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
    [self->scoreLabel release];
    [self->flyingItems release];
    [self->player release];
    [self->aimCross release];
    
    [super dealloc];
}

#pragma mark - JP

- (void)joypadDevice:(JPDevice *)device buttonDown:(JPInputIdentifier)button {
    switch (button) {
        case kJPInputAButton:
            gameSpeedModifier = kGameSpeedSlow;
            self->controlState = kGameControlStateAimControl;
            [self->player controlStop];
            [self->aimCross show];
            break;
            
        case kJPInputBButton:
            [self shoot];
            break;
            
        default:
            break;
    }
}

- (void)joypadDevice:(JPDevice *)device buttonUp:(JPInputIdentifier)button {
    switch (button) {
        case kJPInputAButton:
            gameSpeedModifier = kGameSpeedNormal;
            self->controlState = kGameControlStatePlayerControl;
            [self->player controlStart];
            [self->aimCross hide];
            break;
            
        default:
            break;
    }
}

#pragma mark - Statics

+ (CCScene *)scene {
    CCScene* scene = [CCScene node];
    CCLayer* layer = [GameScreen node];
    [scene addChild:layer];
    return scene;
}

+ (float)worldSpeedMultiplier {
    return gameSpeedModifier;
}

@end
