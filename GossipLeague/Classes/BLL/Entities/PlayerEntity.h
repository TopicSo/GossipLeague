//
//  PlayerEntity.h
//  GossipLeague
//
//  Created by Oriol Blanc on 25/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <Parse/Parse.h>

@interface PlayerEntity : PFObject <PFSubclassing>

@property (nonatomic, readonly) NSString *username;
@property (nonatomic, readonly) NSUInteger winGames;
@property (nonatomic, readonly) NSUInteger lostGames;
@property (nonatomic, readonly) NSUInteger games;

@property (nonatomic, readonly) float percentWins;
@property (nonatomic, readonly) float percentLosts;

@property (nonatomic, readonly) NSString *stringPercentWins;
@property (nonatomic, readonly) NSString *stringPercentLosts;
@property (nonatomic, readonly) NSString *mail;

@end
