//
//  GameEntity.m
//  GossipLeague
//
//  Created by Oriol Blanc on 26/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//
#import "GameEntity.h"
#import "PlayerEntity.h"
#import <NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@implementation GameEntity

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"local": @"local",
             @"visitor": @"visitor",
             @"golsLocal": @"localGoals",
             @"golsVisitor": @"visitorGoals",
             @"playedOn": @"playedOn"
             };
}

+ (NSValueTransformer *)localJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PlayerEntity class]];
}

+ (NSValueTransformer *)visitorJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PlayerEntity class]];
}

#pragma mark - Utils

- (GameResult)gameResult
{
    if (self.golsLocal > self.golsVisitor) {
        return GameResultLocalWins;
    } else if (self.golsLocal < self.golsVisitor) {
        return GameResultVisitorWins;
    }
    
    return GameResultDraw;
}

@end
