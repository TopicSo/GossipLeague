//
//  ComparatorCell.m
//  GossipLeague
//
//  Created by Valenti on 23/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "PlayerBasicCell.h"
#import "PlayerEntity.h"
#import <QuartzCore/QuartzCore.h>

@interface PlayerBasicCell ()
@property (weak, nonatomic) IBOutlet UIView *topShadow;
@property (weak, nonatomic) IBOutlet UIView *bottonShadow;
@property (strong, nonatomic) IBOutlet UIView *colorView;
@end

@implementation PlayerBasicCell

- (void)awakeFromNib
{
    // shadows
    self.topShadow.backgroundColor = [UIColor colorTopShadowCell];
    self.bottonShadow.backgroundColor = [UIColor colorBottomShadowCell];
    
    self.labelName.font = [UIFont fontForUsernameInCell];
    self.labelName.textColor = [UIColor colorTableCellLabel];
    
    self.labelScore.font = [UIFont fontForUsernameInCell];
    self.labelScore.textColor = [UIColor colorTableCellLabel];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id) [[UIColor colorWithWhite:0 alpha:0.01] CGColor], (id) [[UIColor colorWithWhite:0 alpha:0.1] CGColor], nil];
    [self.layer insertSublayer:gradient atIndex:0];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

- (void)setPlayer:(PlayerEntity*)player
{
    self.labelName.text = player.username;
    self.labelScore.text = player.stringScore;
    self.colorView.hidden = YES;
}

- (void)setPlayer:(PlayerEntity *)player position:(NSUInteger)position total:(NSUInteger)total
{
    [self setPlayer:player];
    
    self.colorView.backgroundColor = [[self class] colorForItem:position total:total];
    self.labelName.text = [NSString stringWithFormat:@"%d - %@", position + 1, player.username];
    self.colorView.hidden = NO;
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
