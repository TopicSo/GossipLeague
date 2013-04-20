//
//  GameEntity.h
//  GossipLeague
//
//  Created by Oriol Blanc on 26/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <MTLModel.h>
#import <MTLJSONAdapter.h>

typedef NS_ENUM(NSUInteger, GameResult) {
    GameResultLocalWins,
    GameResultVisitorWins,
    GameResultDraw
};

@class PlayerEntity;

@interface GameEntity : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) PlayerEntity *local;
@property (nonatomic, strong) PlayerEntity *visitor;
@property (nonatomic, assign) NSUInteger golsLocal;
@property (nonatomic, assign) NSUInteger golsVisitor;
@property (nonatomic, strong) NSDate *playedOn;

- (GameResult)gameResult;

@end
