//
//  GossipGamesVC.m
//  GossipLeague
//
//  Created by Giuseppe Basile on 19/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "GamesVC.h"
#import "GameEntity.h"
#import "GameCell.h"

static NSString * const CellGameIdentifier = @"CellGameIdentifier";

@implementation GamesVC

- (id)init
{
    self = [super initWithNibName:@"GamesVC" bundle:nil];
    if (self) {
        self.title = @"Partidos";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeRefreshControl];
    [self setupTableView];
    [self reloadData];
    
    self.tableView.backgroundColor = [UIColor colorBackgroundTableView];
}

- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"GameCell" bundle:nil]
         forCellReuseIdentifier:CellGameIdentifier];
}

- (void)reloadData
{
    OBRequest *request = [OBRequest requestWithType:OBRequestMethodTypeMethodGET resource:@"games" parameters:nil isPublic:YES];
    
    [OBConnection makeRequest:request withCacheKey:NSStringFromClass([self class]) parseBlock:^id(NSDictionary *data) {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.games.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    GameCell *cell = [tableView dequeueReusableCellWithIdentifier:CellGameIdentifier];
    [cell setGame:[self.games objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    
    [super viewDidUnload];
}

#pragma mark - Refresh Control

- (void)initializeRefreshControl
{
    // Initialize Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    // Configure Refresh Control
    [refreshControl addTarget:self action:@selector(refreshContent:) forControlEvents:UIControlEventValueChanged];
    // Configure View Controller
    [self.tableView addSubview:refreshControl];
}

- (void)refreshContent:(UIRefreshControl *)refresh
{
    [self reloadData];
    [refresh endRefreshing];
}

@end
