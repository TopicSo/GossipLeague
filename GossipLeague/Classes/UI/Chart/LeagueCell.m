//
//  TableCell.m
//  GossipLeague
//
//  Created by Oriol Blanc on 25/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "LeagueCell.h"

#import "PlayerEntity.h"

@interface LeagueCell ()
    @property (strong, nonatomic) IBOutlet UIView *colorView;
    @property (strong, nonatomic) IBOutlet UILabel *playerLabel;
    @property (strong, nonatomic) IBOutlet UILabel *winsLabel;

    + (UIColor *)colorForItem:(NSUInteger)item total:(NSUInteger)totalItems;
@end

@implementation LeagueCell

- (void)setPlayer:(PlayerEntity *)player position:(NSUInteger)position total:(NSUInteger)total
{
    self.colorView.backgroundColor = [[self class] colorForItem:position total:total];
    self.playerLabel.text = [NSString stringWithFormat:@"%d - %@", position + 1, player.username];
    self.winsLabel.text = [NSString stringWithFormat:@"%.0f", player.score];
}

+ (UIColor *)colorForItem:(NSUInteger)item total:(NSUInteger)totalItems
{
    /*
     *  Red
     * =======
     *  y = m·x + b
     *  b = 0
     *  m = 1/MAX
     *
     *     y = 1/MAX · x
     *
     *
     *  Green
     * =======
     *  y = m·x + b
     *  b = 1
     *  m = - 1/MAX
     *
     *     y = - 1/MAX · x + 1
     *
     */
    
    float red = ((float)item / ((float)totalItems -1));
    float green = (- 1 / ((float)totalItems - 1) * (float)item) + 1;
    
    return [UIColor colorWithRed:red green:green blue:0 alpha:1];
}

@end
