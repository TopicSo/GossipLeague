//
//  ComperatorCell.h
//  GossipLeague
//
//  Created by Valenti on 23/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerEntity;

@interface ComperatorCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *labelName;
@property (nonatomic,strong) IBOutlet UILabel *labelScore;

- (void)setPlayerToCell:(PlayerEntity*)player;
@end
