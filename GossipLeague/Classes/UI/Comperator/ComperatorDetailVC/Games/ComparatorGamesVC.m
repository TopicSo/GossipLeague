//
//  ComparatorGamesVC.m
//  GossipLeague
//
//  Created by Giuseppe Basile on 27/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "ComparatorGamesVC.h"
#import "GameEntity.h"
#import "PlayerEntity.h"

@interface ComparatorGamesVC ()
@property (nonatomic, retain) PlayerEntity *player1;
@property (nonatomic, retain) PlayerEntity *player2;
@end

@implementation ComparatorGamesVC

- (id)initWithPlayer:(PlayerEntity *)player1 andPlayer:(PlayerEntity *)player2
{
    self = [self init];
    if (self) {
        self.player1 = player1;
        self.player2 = player2;
    }
    return self;
}
- (void)reloadData
{
    NSString *resource = [NSString stringWithFormat:@"games?player1Id=%@&player2Id=%@", self.player1.idUser, self.player2.idUser];
    
    OBRequest *request = [OBRequest requestWithType:OBRequestMethodTypeMethodGET resource:resource parameters:nil isPublic:YES];
    
    [OBConnection makeRequest:request withCacheKey:NSStringFromClass([self class]) parseBlock:^id(NSDictionary *data) {
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
