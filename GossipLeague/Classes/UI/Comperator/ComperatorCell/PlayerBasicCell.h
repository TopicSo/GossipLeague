//
//  ComparatorCell.h
//  GossipLeague
//
//  Created by Valenti on 23/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerEntity;

@interface PlayerBasicCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *labelName;
@property (nonatomic,strong) IBOutlet UILabel *labelScore;

- (void)setPlayer:(PlayerEntity *)player;
- (void)setPlayer:(PlayerEntity *)player position:(NSUInteger)position total:(NSUInteger)total;

@end
