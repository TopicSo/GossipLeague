//
//  RankingEntity.h
//  GossipLeague
//
//  Created by Oriol Blanc on 11/05/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface RankingEntity : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray *rankedPlayers;
@property (nonatomic, strong) NSArray *unclassifiedPlayers;
@property (nonatomic, assign) NSUInteger breakEvenPoint;

@property (nonatomic, readonly) NSUInteger countDivisions;

@end
