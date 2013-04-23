//
//  ComperatorDetailVC.m
//  GossipLeague
//
//  Created by Valenti on 23/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "ComperatorDetailVC.h"
#import "PlayerEntity.h"
#import "GameEntity.h"
#import "GameCell.h"
#import "UIImageView+AFNetworking.h"

static NSString * const CellGameIdentifier = @"CellGameIdentifier";

@interface ComperatorDetailVC ()

//header
@property (nonatomic,strong) IBOutlet UIImageView *imageViewProfilePlayer1;
@property (nonatomic,strong) IBOutlet UIImageView *imageViewProfilePlayer2;

//Entities
@property (nonatomic,strong) PlayerEntity *player1;
@property (nonatomic,strong) PlayerEntity *player2;

//TV
@property (strong, nonatomic) IBOutlet UITableView  *tableView;
@property (strong, nonatomic) NSArray               *games;

@end

@implementation ComperatorDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil player1:(PlayerEntity*)player1_ player2:(PlayerEntity*)player2_
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.player1 = player1_;
        self.player2 = player2_;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"VS";
    [self.imageViewProfilePlayer1 setImageWithURL:[NSURL URLWithString:self.player1.avatarURL]];
    [self.imageViewProfilePlayer2 setImageWithURL:[NSURL URLWithString:self.player2.avatarURL]];

    [self initializeRefreshControl];
    [self setupTableView];
    [self reloadData];

}


//TODO: MOVE TO SUPER CLASS WITH TABLEVIEW GAMES IF THE DESIGN KEEP IT THE SAME.
- (void)setupTableView
{
    self.tableView.rowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"GameCell" bundle:nil]
         forCellReuseIdentifier:CellGameIdentifier];
}

- (void)reloadData
{
    NSString *resource = [NSString stringWithFormat:@"games?player1Id=%@&player2Id=%@",self.player1.idUser,self.player2.idUser];
    NSLog(@"resource = %@", resource);
    
    OBRequest *request = [OBRequest requestWithType:OBRequestMethodTypeMethodGET resource:resource parameters:nil isPublic:YES];
    
    [OBConnection makeRequest:request withCacheKey:NSStringFromClass([self class]) parseBlock:^id(NSDictionary *data) {
        NSMutableArray *parsedGames = [NSMutableArray array];
        
        for (NSDictionary *tmpGame in [data objectForKey:@"games"])
        {
            GameEntity *game = [MTLJSONAdapter modelOfClass:[GameEntity class] fromJSONDictionary:tmpGame error:nil];
            [parsedGames addObject:game];
        }
        
        return parsedGames;
    } success:^(NSArray *parsedGames, BOOL cached)
    {
        self.games = [[parsedGames reverseObjectEnumerator] allObjects];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    GameEntity *game = [self.games objectAtIndex:indexPath.row];
//    UserDetailVC *userDetailVC = [[UserDetailVC alloc] initWithPlayer:player];
//    [self.navigationController pushViewController:userDetailVC animated:YES];
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (void)viewDidUnload
{
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
    
    [self reloadData];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",
                             [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [refresh endRefreshing];
}


@end
