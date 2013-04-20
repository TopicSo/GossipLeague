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

static NSString * const CellIdentifier = @"UserDetailCell";

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
    
    self.tableView.backgroundView = nil;
    [self.tableView registerNib:[UINib nibWithNibName:@"UserDetailCell" bundle:nil]
         forCellReuseIdentifier:CellIdentifier];
    
//    self.gamesLabel.text = [NSString stringWithFormat:@"Games: %d", self.player.games];
//    self.winsLabel.text = [NSString stringWithFormat:@"Wins: %d", self.player.winGames];
//    self.lostsLabel.text = [NSString stringWithFormat:@"Losts: %d", self.player.lostGames];
//    self.drawLabel.text = [NSString stringWithFormat:@"Draw: %d", self.player.games - (self.player.lostGames + self.player.winGames)];
    
    
    [self loadGravatarImage];
}

- (void)loadGravatarImage
{
    NSString *hash = [self md5:self.player.email];
    if (!hash) {
        return;
    }
    
    NSURL *gravatarUrl = [NSURL URLWithString:[NSString
                                               stringWithFormat:@"http://gravatar.com/avatar/%@?s=%@",hash, @(250)]];
    
    [self.avatarImageView setImageWithURL:gravatarUrl];
}

- (NSString *)md5:(NSString *)input
{
    if (!input) {
        return nil;
    }
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

#pragma mark - Table View Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
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
