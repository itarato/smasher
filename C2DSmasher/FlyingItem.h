//
//  FlyingItem.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/15/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SmasherTypes.h"
#import "FlyingItemDelegate.h"

@interface FlyingItem : CCSprite {
    float speed;
    id<FlyingItemDelegate> delegate;
    int score;
}

- (void)die:(FlyingItemDeathType)deathType;

+ (FlyingItem *)flyingItemOfType:(FlyingItemType)type;

@property (nonatomic, assign) id<FlyingItemDelegate> delegate;
@property (atomic, readonly) int score;

@end
