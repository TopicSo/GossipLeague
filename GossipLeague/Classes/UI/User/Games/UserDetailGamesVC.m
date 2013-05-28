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

static NSUInteger const kRecsPerPage = 60;

@interface UserDetailGamesVC ()

@property (nonatomic, retain) PlayerEntity *player;
@property (nonatomic) GameType gameType;

@end

@implementation UserDetailGamesVC

- (id)initWithPlayer:(PlayerEntity *)player gameType:(GameType)type
{
    if (self = [self init])
    {
        self.player = player;
        self.gameType = type;
    }
    return self;
}

- (NSString *)resourceForType
{
    NSString *resourceResult;
    
    switch (self.gameType)
    {
        case GameTypeAll:
            resourceResult = @"games?player1Id=";
            break;
            
        case GameTypeWon:
            resourceResult = @"games/wins?playerId=";
            break;
            
        case GameTypeDrawn:
            resourceResult = @"games/draws?playerId=";
            break;
            
        case GameTypeLost:
            resourceResult = @"games/losts?playerId=";            
            break;
    }
    
    return resourceResult;
}

- (void)reloadData
{
    NSString *resource = [NSString stringWithFormat:@"%@%@&recsPerPage=%lu", [self resourceForType] ,self.player.idUser, (unsigned long)kRecsPerPage];
    
    OBRequest *request = [OBRequest requestWithType:OBRequestMethodTypeMethodGET resource:resource parameters:nil isPublic:YES];
    
    [OBConnection makeRequest:request withCacheKey:resource parseBlock:^id(NSDictionary *data) {
        NSMutableArray *parsedGames = [NSMutableArray array];
        
        self.games = [[NSArray alloc] init];
        
        for (NSDictionary *tmpGame in [data objectForKey:@"games"]) {
            GameEntity *game = [MTLJSONAdapter modelOfClass:[GameEntity class] fromJSONDictionary:tmpGame error:nil];
            [parsedGames addObject:game];
        }
        
        return parsedGames;
    } success:^(NSArray *parsedGames, BOOL cached) {
        self.games = parsedGames;
        [self.tableView reloadData];
    } error:NULL];
}

@end
