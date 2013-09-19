//
//  FlyingItemDelegate.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/15/13.
//  Copyright (c) 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmasherTypes.h"

@class FlyingItem;

@protocol FlyingItemDelegate <NSObject>

@optional

- (void)flyingItemDied:(FlyingItem *)item withType:(FlyingItemDeathType)deathType;

@end
