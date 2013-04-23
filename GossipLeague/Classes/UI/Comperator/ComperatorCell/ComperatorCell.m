//
//  ComperatorCell.m
//  GossipLeague
//
//  Created by Valenti on 23/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "ComperatorCell.h"
#import "PlayerEntity.h"

@implementation ComperatorCell
@synthesize labelName = _labelName;
@synthesize labelScore = _labelScore;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPlayerToCell:(PlayerEntity*)player
{
    [self.labelName setText:player.username];
    [self.labelScore setText:[NSString stringWithFormat:@"%f",player.score]];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

@end
