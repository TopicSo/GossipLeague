//
//  PlayerEntity.h
//  GossipLeague
//
//  Created by Oriol Blanc on 25/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <Parse/Parse.h>

@interface PlayerEntity : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) double score;

@property (nonatomic, assign) NSUInteger winGames;
@property (nonatomic, assign) NSUInteger lostGames;
@property (nonatomic, assign) NSUInteger games;
@property (nonatomic, assign) NSUInteger drawGames;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
