//
//  ComparatorCell.h
//  GossipLeague
//
//  Created by Valenti on 23/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerEntity;

@interface ComparatorCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *labelName;
@property (nonatomic,strong) IBOutlet UILabel *labelScore;

- (void)setPlayerToCell:(PlayerEntity*)player;
@end
