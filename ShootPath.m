//
//  ShootPath.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/20/13.
//  Copyright 2013 Peter Arato. All rights reserved.
//

#import "ShootPath.h"

@interface ShootPath ()

- (void)kill;

@end

@implementation ShootPath

- (id)init {
    if ((self = [super init])) {
        self->isGrow = YES;
        self->intensity = 0.0f;
        [self schedule:@selector(updateIntensity:)];
    }
    return self;
}

- (void)kill {
    [self.parent removeChild:self];
}

- (void)updateIntensity:(ccTime)time {
    if (self->isGrow) {
        if (self->intensity < 1.0f) {
            self->intensity += kShootPathStep;
        }
        else {
            self->isGrow = NO;
        }
    }
    else {
        if (self->intensity > 0.0f) {
            self->intensity -= kShootPathStep;
        }
        else {
            [self kill];
        }
    }
}

- (void)draw {
    glLineWidth(10.0f);
    ccGLEnable(GL_LINE_STRIP);
    ccDrawColor4F(1.0f, 1.0f, 1.0f, self->intensity);
    ccDrawLine(self->from, self->to);
}

+ (ShootPath *)shootPathFrom:(CGPoint)from to:(CGPoint)to {
    ShootPath *shootPath = [ShootPath node];
    shootPath->from = from;
    shootPath->to = to;
    return shootPath;
}

@end
