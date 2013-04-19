//
//  GossipGameCell.m
//  GossipLeague
//
//  Created by Giuseppe Basile on 19/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "GossipGameCell.h"
#import "GameEntity.h"
#import "PlayerEntity.h"

@interface GossipGameCell ()
@property (weak, nonatomic) IBOutlet UILabel *playerALabel;
@property (weak, nonatomic) IBOutlet UILabel *golsALabel;
@property (weak, nonatomic) IBOutlet UILabel *playerBLabel;
@property (weak, nonatomic) IBOutlet UILabel *golsBLabel;
@property (weak, nonatomic) IBOutlet UIView *playerAIndicator;
@property (weak, nonatomic) IBOutlet UIView *playerBIndicator;
@property (weak, nonatomic) IBOutlet UILabel *gameDate;
@end

@implementation GossipGameCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setGame:(GameEntity *)game
{
    self.playerALabel.text = game.local.username;
    self.playerBLabel.text = game.visitor.username;
    
    if (game.golsLocal > game.golsVisitor) {
        self.playerAIndicator.backgroundColor = [UIColor greenColor];
        self.playerBIndicator.backgroundColor = [UIColor redColor];
    } else if (game.golsLocal < game.golsVisitor) {
        self.playerAIndicator.backgroundColor = [UIColor redColor];
        self.playerBIndicator.backgroundColor = [UIColor greenColor];
    } else {
        self.playerAIndicator.backgroundColor = [UIColor yellowColor];
        self.playerBIndicator.backgroundColor = [UIColor yellowColor];
    }
    
    self.golsALabel.text = [NSString stringWithFormat:@"%u", game.golsLocal];
    self.golsBLabel.text = [NSString stringWithFormat:@"%u", game.golsVisitor];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    self.gameDate.text = [dateFormatter stringFromDate:game.playedOn];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
