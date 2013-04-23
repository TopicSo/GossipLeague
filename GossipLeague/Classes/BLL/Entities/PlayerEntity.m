//
//  PlayerEntity.m
//  GossipLeague
//
//  Created by Oriol Blanc on 25/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "PlayerEntity.h"

@implementation PlayerEntity

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"idUser": @"id",
             @"username": @"username",
             @"email": @"email",
             @"score": @"score",
             @"winGames": @"countWins",
             @"lostGames": @"countLosts",
             @"games": @"countGames",
             @"drawGames": @"countDraws",
             @"avatarURL": @"avatar",
             @"scoredGoals": @"countScoredGoals",
             @"concededGoals": @"countConcededGoals"
             };
}

@end
