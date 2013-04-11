//
//  UserDetailVC.m
//  GossipLeague
//
//  Created by Oriol Blanc on 10/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "UserDetailVC.h"
#import "PlayerEntity.h"
#import <CommonCrypto/CommonDigest.h>

@interface UserDetailVC ()
@property (nonatomic, strong) PlayerEntity *player;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *gamesLabel;
@property (strong, nonatomic) IBOutlet UILabel *winsLabel;
@property (strong, nonatomic) IBOutlet UILabel *lostsLabel;
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
    self.usernameLabel.text = self.player.username;
    self.gamesLabel.text = [NSString stringWithFormat:@"Games: %d", self.player.games];
    self.winsLabel.text = [NSString stringWithFormat:@"Wins: %d", self.player.winGames];
    self.lostsLabel.text = [NSString stringWithFormat:@"Losts: %d", self.player.lostGames];
    [self loadGravatarImage];
}

- (void)loadGravatarImage
{
    NSString *hash = [self md5:self.player.mail];
    if (!hash) {
        return;
    }
    
    NSURL *gravatarUrl = [NSURL URLWithString:[NSString
                                               stringWithFormat:@"http://gravatar.com/avatar/%@?s=%@",hash, @(250)]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:gravatarUrl];
        if (imageData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.avatarImageView.image = [UIImage imageWithData:imageData];
            });
        }
    });
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

- (void)viewDidUnload {
    [self setUsernameLabel:nil];
    [self setAvatarImageView:nil];
    [self setGamesLabel:nil];
    [self setWinsLabel:nil];
    [self setLostsLabel:nil];
    [super viewDidUnload];
}
@end
