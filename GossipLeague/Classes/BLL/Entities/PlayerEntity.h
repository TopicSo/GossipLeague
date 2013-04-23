//
//  PlayerEntity.h
//  GossipLeague
//
//  Created by Oriol Blanc on 25/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface PlayerEntity : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *idUser;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) double score;
@property (nonatomic, copy) NSString *avatarURL;

@property (nonatomic, assign) NSUInteger winGames;
@property (nonatomic, assign) NSUInteger lostGames;
@property (nonatomic, assign) NSUInteger games;
@property (nonatomic, assign) NSUInteger drawGames;
@property (nonatomic, assign) NSUInteger scoredGoals;
@property (nonatomic, assign) NSUInteger concededGoals;

@end
