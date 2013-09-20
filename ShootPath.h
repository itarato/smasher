//
//  ShootPath.h
//  C2DSmasher
//
//  Created by Peter Arato on 9/20/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define kShootPathStep 0.2f

@interface ShootPath : CCLayer {
    CGPoint from;
    CGPoint to;
    float intensity;
    BOOL isGrow;
}

- (void)updateIntensity:(ccTime)time;

+ (ShootPath *)shootPathFrom:(CGPoint)from to:(CGPoint)to;

@end
