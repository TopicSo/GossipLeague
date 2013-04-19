//
//  GameEntity.h
//  GossipLeague
//
//  Created by Oriol Blanc on 26/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

@class PlayerEntity;

@interface GameEntity : NSObject

@property (nonatomic, strong) PlayerEntity *local;
@property (nonatomic, strong) PlayerEntity *visitor;
@property (nonatomic, assign) NSUInteger golsLocal;
@property (nonatomic, assign) NSUInteger golsVisitor;
@property (nonatomic, strong) NSDate *playedOn;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
