//
//  UserDetailVC.m
//  GossipLeague
//
//  Created by Oriol Blanc on 10/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "UserDetailVC.h"
#import "PlayerEntity.h"
#import "UserDetailCell.h"
#import <CommonCrypto/CommonDigest.h>

#import "UIImageView+AFNetworking.h"

static NSString * const CellIUserdentifier = @"UserDetailCell";

@interface UserDetailVC ()
@property (nonatomic, strong) PlayerEntity *player;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserDetailVC

- (id)initWithPlayer:(PlayerEntity *)player;
{
    self = [super init];
    if (self) {
        self.player = player;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView addSubview:self.containerView];
    self.scrollView.contentSize = self.containerView.bounds.size;
    self.usernameLabel.text = self.player.username;
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:self.player.avatarURL]];
    
    self.tableView.backgroundView = nil;
    [self.tableView registerNib:[UINib nibWithNibName:@"UserDetailCell" bundle:nil]
         forCellReuseIdentifier:CellIUserdentifier];
}

#pragma mark - Table View Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIUserdentifier];
    
    NSArray *leftValues = @[@"Games", @"Wins", @"Draws", @"Losts", @"Goals Scored", @"Goals Conceded"];
    NSArray *rightValues = @[@(self.player.games), @(self.player.winGames), @(self.player.drawGames), @(self.player.lostGames), @(self.player.scoredGoals), @(self.player.concededGoals)];
    
    cell.leftLabel.text = leftValues[indexPath.row];
    cell.rightLabel.text = [rightValues[indexPath.row] description];
    
    return cell;
}

- (void)viewDidUnload {
    [self setUsernameLabel:nil];
    [self setAvatarImageView:nil];
    
    [self setScrollView:nil];
    [self setContainerView:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
