//
//  UserDetailGamesVC.m
//  GossipLeague
//
//  Created by Giuseppe Basile on 28/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "UserDetailGamesVC.h"
#import "PlayerEntity.h"
#import "GameEntity.h"

@interface UserDetailGamesVC ()
@property (nonatomic, retain) PlayerEntity *player;
@end

@implementation UserDetailGamesVC

- (id)initWithPlayer:(PlayerEntity *)player
{
    self = [self init];
    if (self) {
        self.player = player;
    }
    return self;
}

- (void)reloadData
{
    NSString *resource = [NSString stringWithFormat:@"games?player1Id=%@", self.player.idUser];
    
    OBRequest *request = [OBRequest requestWithType:OBRequestMethodTypeMethodGET resource:resource parameters:nil isPublic:YES];
    
    [OBConnection makeRequest:request withCacheKey:resource parseBlock:^id(NSDictionary *data) {
        NSMutableArray *parsedGames = [NSMutableArray array];
        
        for (NSDictionary *tmpGame in [data objectForKey:@"games"]) {
            GameEntity *game = [MTLJSONAdapter modelOfClass:[GameEntity class] fromJSONDictionary:tmpGame error:nil];
            [parsedGames addObject:game];
        }
        
        return parsedGames;
    } success:^(NSArray *parsedGames, BOOL cached) {
        [self.tableView reloadData];
    } error:NULL];
}

@end
