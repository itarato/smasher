//
//  EnemyItem.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/17/13.
//  Copyright (c) 2013 Peter Arato. All rights reserved.
//

#import "EnemyItem.h"

@implementation EnemyItem

- (id)initWithFile:(NSString *)filename {
    if ((self = [super initWithFile:filename])) {
        self->score = 10;
    }
    return self;
}

+ (EnemyItem *)enemy {
    return [EnemyItem spriteWithFile:@"meteorSmall.png"];
}

@end
