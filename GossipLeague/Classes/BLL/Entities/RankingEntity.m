//
//  RankingEntity.m
//  GossipLeague
//
//  Created by Oriol Blanc on 11/05/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "RankingEntity.h"
#import "PlayerEntity.h"
#import <NSValueTransformer+MTLPredefinedTransformerAdditions.h>
#import "MTLValueTransformer.h"

@implementation RankingEntity 

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"rankedPlayers": @"players",
             @"unclassifiedPlayers": @"bottomPlayers",
             @"breakEvenPoint": @"breakEvenPoint"
            };
}

+ (NSValueTransformer *)rankedPlayersJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[PlayerEntity class]];
}

+ (NSValueTransformer *)unclassifiedPlayersJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[PlayerEntity class]];
}

#pragma mark - Readonly

- (NSUInteger)countDivisions
{
    NSUInteger countDivisions = 0;
    
    if(self.rankedPlayers.count > 0)
        countDivisions++;
    
    if(self.unclassifiedPlayers.count > 0)
        countDivisions++;
        
    return countDivisions;
}

@end
