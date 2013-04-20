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

@interface GamesVC ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *games;

@end

@implementation GamesVC

- (id)init
{
    self = [super init];
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
    self.tableView.rowHeight = 50;
    [self initializeRefreshControl];
    [self setUp];
}

- (void)setUp
{
    OBRequest *request = [OBRequest requestWithType:OBRequestMethodTypeMethodGET resource:@"games/" parameters:nil isPublic:YES];
    
    [OBConnection makeRequest:request success:^(id data, BOOL cached) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *tmpGame in [data objectForKey:@"games"]) {
            GameEntity *game = [[GameEntity alloc] initWithDictionary:tmpGame];
            [array addObject:game];
        }
        
        self.games = [[array reverseObjectEnumerator] allObjects];
        
        [self.tableView reloadData];
        
    } error:NULL];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.games.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GossipGameCell";
    
    GameCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UINib *cellNib = [UINib nibWithNibName:@"GossipGameCell" bundle:nil];
        cell = [[cellNib instantiateWithOwner:self options:nil] objectAtIndex:0];
    }
    
    [cell setGame:[self.games objectAtIndex:indexPath.row]];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    GameEntity *game = [self.games objectAtIndex:indexPath.row];
//    UserDetailVC *userDetailVC = [[UserDetailVC alloc] initWithPlayer:player];
//    [self.navigationController pushViewController:userDetailVC animated:YES];
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    
    [self setUp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",
                             [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [refresh endRefreshing];
}


@end
