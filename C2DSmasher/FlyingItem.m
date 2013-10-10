//
//  FlyingItem.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/15/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "FlyingItem.h"
#import "FoodItem.h"
#import "EnemyItem.h"
#import "GameScreen.h"

#define kFlyingItemSpeed 20.0f

@implementation FlyingItem

@synthesize delegate;
@synthesize score;

- (id)initWithFile:(NSString *)filename {
    if ((self = [super initWithFile:filename])) {
        CGSize win_size = [[CCDirector sharedDirector] winSize];
        [self setPosition:ccp(win_size.width, win_size.height * CCRANDOM_0_1())];
        
        self->speed = (CCRANDOM_0_1() * 0.5f + 0.5f) * kFlyingItemSpeed;
        self->score = 0;
        
        [self scheduleUpdate];
    }
    return self;
}

- (void)update:(ccTime)delta {
    [self setPosition:ccp(self.position.x - self->speed * [GameScreen worldSpeedMultiplier], self.position.y)];
    if (self.position.x <= 0) {
        [self die:kFlyingItemOutOufScreen];
    }
}

- (void)die:(FlyingItemDeathType)deathType {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(flyingItemDied:withType:)]) {
            [self.delegate flyingItemDied:self withType:deathType];
        }
    }
    [self unscheduleUpdate];
    [self.parent removeChild:self];
}

+ (FlyingItem *)flyingItemOfType:(FlyingItemType)type {
    FlyingItem *item = nil;
    switch (type) {
        case kFlyingItemFood:
            item = [FoodItem food];
            break;
            
        case kFlyingItemEnemy:
            item = [EnemyItem enemy];
            break;
            
        default:
            break;
    }
    return item;
}

@end
