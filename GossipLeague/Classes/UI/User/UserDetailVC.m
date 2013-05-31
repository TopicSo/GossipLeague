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
#import "UserDetailGamesVC.h"

#import "UIImageView+AFNetworking.h"

static NSString * const CellIUserdentifier = @"UserDetailCell";

@interface UserDetailVC ()

@property (strong, nonatomic) PlayerEntity *player;

@property (strong, nonatomic) IBOutlet UIView *userInfoView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserDetailVC

- (id)initWithPlayer:(PlayerEntity *)player;
{
    if (self = [super init])
    {
        self.player = player;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupBasicInfomation];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
}

- (void)goToGamesWithType:(GameType)type
{
    UserDetailGamesVC *userDetailGames = [[UserDetailGamesVC alloc] initWithPlayer:self.player gameType:type];
    [self.navigationController pushViewController:userDetailGames animated:YES];
}

- (void)setupBasicInfomation
{
    self.usernameLabel.font = [UIFont fontForUsernameInCell];
    self.usernameLabel.textColor = [UIColor colorTableCellLabel];
    self.usernameLabel.text = self.player.username;
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:self.player.avatarURL]];
}

- (void)setupTableView
{
    self.tableView.backgroundView = nil;
    [self.tableView registerNib:[UINib nibWithNibName:@"UserDetailCell" bundle:nil]
         forCellReuseIdentifier:CellIUserdentifier];
    self.tableView.tableHeaderView = self.userInfoView;
    self.tableView.backgroundColor = [UIColor colorBackgroundTableView];
}

#pragma mark - Table View Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIUserdentifier];
    
    NSArray *leftValues = @[@"Games", @"Wins", @"Draws", @"Losses", @"Goals Scored", @"Goals Conceded"];
    NSArray *rightValues = @[@(self.player.games), @(self.player.winGames), @(self.player.drawGames), @(self.player.lostGames), @(self.player.scoredGoals), @(self.player.concededGoals)];
    
    cell.leftLabel.text = leftValues[indexPath.row];
    cell.rightLabel.text = [rightValues[indexPath.row] description];
    cell.accessoryType = indexPath.row <= 3 ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    cell.selectionStyle = indexPath.row <= 3 ? UITableViewCellSelectionStyleGray : UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            
        case 0:
            [self goToGamesWithType:GameTypeAll];
            break;
            
        case 1:
            [self goToGamesWithType:GameTypeWon];
            break;
            
        case 2:
            [self goToGamesWithType:GameTypeDrawn];
            break;
            
        case 3:
            [self goToGamesWithType:GameTypeLost];
            break;
            
        default:
            break;
    }
}

- (void)viewDidUnload {
    [self setUsernameLabel:nil];
    [self setAvatarImageView:nil];
    [self setTableView:nil];
    [self setUserInfoView:nil];
    [super viewDidUnload];
}
@end
