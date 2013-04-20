//
//  TableCell.h
//  GossipLeague
//
//  Created by Oriol Blanc on 25/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

@class PlayerEntity;

@interface LeagueCell : UITableViewCell

- (void)setPlayer:(PlayerEntity *)player position:(NSUInteger)position total:(NSUInteger)total;

@end
