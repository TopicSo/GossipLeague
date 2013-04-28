//
//  ComparatorGamesVC.h
//  GossipLeague
//
//  Created by Giuseppe Basile on 27/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "GamesVC.h"

@class PlayerEntity;

@interface ComparatorGamesVC : GamesVC
- (id)initWithPlayer:(PlayerEntity *)player1 andPlayer:(PlayerEntity *)player2;
@end
