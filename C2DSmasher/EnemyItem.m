//
//  EnemyItem.m
//  C2DSmasher
//
//  Created by Peter Arato on 9/17/13.
//  Copyright (c) 2013 Peter Arato. All rights reserved.
//

#import "EnemyItem.h"

@implementation EnemyItem

+ (EnemyItem *)enemy {
    return [EnemyItem spriteWithFile:@"enemy.png"];
}

@end
