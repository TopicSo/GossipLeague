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

- (double)winGamesPor100
{
    return ((double)self.winGames/self.games) * 100;
}

- (double)drawGamesPor100
{
    return ((double)self.drawGames/self.games) * 100;
}

- (double)lostGamesPor100
{
    return ((double)self.lostGames/self.games) * 100;
}

- (double)goalsRatio
{
    return ((double)self.scoredGoals/self.concededGoals);
}

@end
