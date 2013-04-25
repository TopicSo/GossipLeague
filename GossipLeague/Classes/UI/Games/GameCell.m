//
//  GossipGameCell.m
//  GossipLeague
//
//  Created by Giuseppe Basile on 19/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "GameCell.h"
#import "GameEntity.h"
#import "PlayerEntity.h"

#import <QuartzCore/QuartzCore.h>

@interface GameCell ()

// main
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) IBOutlet UIView *topShadow;
@property (weak, nonatomic) IBOutlet UIView *bottonShadow;
@property (weak, nonatomic) IBOutlet UIView *scoreView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

// player A
@property (weak, nonatomic) IBOutlet UILabel *playerALabel;
@property (weak, nonatomic) IBOutlet UILabel *goalsALabel;

// player B
@property (weak, nonatomic) IBOutlet UILabel *playerBLabel;
@property (weak, nonatomic) IBOutlet UILabel *goalsBLabel;

@end

@implementation GameCell

- (void)awakeFromNib
{
    // shadows
    self.topShadow.backgroundColor = [UIColor colorTopShadowCell];
    self.bottonShadow.backgroundColor = [UIColor colorBottomShadowCell];
    
    self.scoreView.layer.cornerRadius = 4.0f;
    self.scoreView.layer.shadowOffset = CGSizeMake(0, -1);
    self.goalsALabel.layer.cornerRadius = 2.0f;
    self.goalsBLabel.layer.cornerRadius = 2.0f;
    
    // labels
    
    self.dateLabel.font = [UIFont fontForDateInCell];
    self.dateLabel.textColor = [UIColor colorDateLabel];
    
    self.playerALabel.font = [UIFont fontForUsernameInCell];
    self.playerALabel.backgroundColor = [UIColor colorBackgroundTableView];
    
    self.playerBLabel.font = [UIFont fontForUsernameInCell];
    self.playerBLabel.backgroundColor = [UIColor colorBackgroundTableView];

    self.goalsALabel.font = [UIFont fontForGoalsInCell];
    self.goalsALabel.backgroundColor = [UIColor colorBackgroundTableView];
    
    self.goalsBLabel.font = [UIFont fontForGoalsInCell];
    self.goalsBLabel.backgroundColor = [UIColor colorBackgroundTableView];
}

- (void)setGame:(GameEntity *)game
{
    self.playerALabel.text = game.local.username;
    self.playerBLabel.text = game.visitor.username;
    
    GameResult gameResult = [game gameResult];
    switch (gameResult) {
        case GameResultLocalWins:
            self.playerALabel.textColor = [UIColor colorWinLabel];
            self.goalsALabel.backgroundColor = [UIColor colorWinCard];
            self.playerBLabel.textColor = [UIColor colorLostLabel];
            self.goalsBLabel.backgroundColor = [UIColor colorLostCard];
            break;
        case GameResultVisitorWins:
            self.playerALabel.textColor = [UIColor colorLostLabel];
            self.goalsALabel.backgroundColor = [UIColor colorLostCard];
            self.playerBLabel.textColor = [UIColor colorWinLabel];
            self.goalsBLabel.backgroundColor = [UIColor colorWinCard];
            break;
        default:
            self.playerALabel.textColor = [UIColor colorDrawLabel];
            self.goalsALabel.backgroundColor = [UIColor colorDrawCard];
            self.playerBLabel.textColor = [UIColor colorDrawLabel];
            self.goalsBLabel.backgroundColor = [UIColor colorDrawCard];
            break;
    }
    
    self.goalsALabel.text = [NSString stringWithFormat:@"%u", game.golsLocal];
    self.goalsBLabel.text = [NSString stringWithFormat:@"%u", game.golsVisitor];
    self.dateLabel.text = [self.dateFormatter stringFromDate:game.playedOn];
}

#pragma mark - Getters
- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"dd/MM/yyyy·hh:mm"];
    }
    
    return _dateFormatter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
