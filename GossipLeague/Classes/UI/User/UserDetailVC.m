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
@property (strong, nonatomic) IBOutlet UIView *userInfoView;
@property (nonatomic, strong) PlayerEntity *player;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
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
    
    [self setupUIBar];
    [self setupBasicInfomation];
    [self setupTableView];
}

- (void)setupUIBar
{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Games" style:UIBarButtonItemStyleBordered target:self action:@selector(goToGames)];
    [self.navigationItem setRightBarButtonItem:barButton];
}

- (void)goToGames
{
    UserDetailGamesVC *userDetailGames = [[UserDetailGamesVC alloc] initWithPlayer:self.player];
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
    
    NSArray *leftValues = @[@"Games", @"Wins", @"Draws", @"Losts", @"Goals Scored", @"Goals Conceded"];
    NSArray *rightValues = @[@(self.player.games), @(self.player.winGames), @(self.player.drawGames), @(self.player.lostGames), @(self.player.scoredGoals), @(self.player.concededGoals)];
    
    cell.leftLabel.text = leftValues[indexPath.row];
    cell.rightLabel.text = [rightValues[indexPath.row] description];
    
    return cell;
}

- (void)viewDidUnload {
    [self setUsernameLabel:nil];
    [self setAvatarImageView:nil];
    [self setTableView:nil];
    [self setUserInfoView:nil];
    [super viewDidUnload];
}
@end
