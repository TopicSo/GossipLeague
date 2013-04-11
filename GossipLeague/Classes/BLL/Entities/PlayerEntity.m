//
//  PlayerEntity.m
//  GossipLeague
//
//  Created by Oriol Blanc on 25/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "PlayerEntity.h"

@implementation PlayerEntity

- (NSString *)username
{
    return [self objectForKey:@"username"];
}

- (NSUInteger)games
{
    return [[self objectForKey:@"games"] intValue];
}

- (NSUInteger)winGames
{
    return [[self objectForKey:@"wins"] intValue];
}

- (NSUInteger)lostGames
{
    return [[self objectForKey:@"losts"] intValue];
}

- (float)percentWins
{
    float games = self.games;
    return self.winGames / games * 100;
}

- (float)percentLosts
{
    float games = self.games;
    return self.lostGames / games * 100;
}

- (NSString *)stringPercentWins
{
    return [NSString stringWithFormat:@"%.1f%%", self.percentWins];
}

- (NSString *)stringPercentLosts
{
    return [NSString stringWithFormat:@"%.1f%%", self.percentLosts];
}

- (NSString *)mail
{
    return [self objectForKey:@"mail"];
}

#pragma mark - Subclassing

+ (id)object
{
    return [[self alloc] init];
}

+ (id)objectWithoutDataWithObjectId:(NSString *)objectId
{
    return [[super class] objectWithoutDataWithObjectId:objectId];
}

+ (NSString *)parseClassName
{
    return @"Player";
}

+ (PFQuery *)query
{
    return [[super class] query];
}

@end
