#import "LeagueVC.h"
#import <Parse/Parse.h>
#import <Parse/PFQueryTableViewController.h>
#import "PlayerBasicCell.h"
#import "PlayerEntity.h"
#import "UserDetailVC.h"

static NSString * const CellLeagueIdentifier = @"PlayerBasicCell";

@interface LeagueVC () <UITableViewDataSource, UIAccelerometerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *players;

- (void)reloadData;

@end

@implementation LeagueVC

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Liga Gossip HUB";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayerBasicCell" bundle:nil]
         forCellReuseIdentifier:CellLeagueIdentifier];
    self.tableView.backgroundColor = [UIColor colorBackgroundTableView];
    [self initializeRefreshControl];
    [self reloadData];
}

- (void)reloadData
{
    OBRequest *request = [OBRequest requestWithType:OBRequestMethodTypeMethodGET resource:@"players/ranking" parameters:nil isPublic:YES];
    
    [OBConnection makeRequest:request withCacheKey:NSStringFromClass([self class]) parseBlock:^id(NSDictionary *data) {
        NSMutableArray *parsedPlayers = [NSMutableArray array];
        
        for (NSDictionary *tmpPlayer in [data objectForKey:@"players"]) {
            PlayerEntity *player = [MTLJSONAdapter modelOfClass:[PlayerEntity class] fromJSONDictionary:tmpPlayer error:nil];
            [parsedPlayers addObject:player];
        }
        
        return parsedPlayers;
    } success:^(NSArray *parsedPlayers, BOOL cached) {
        self.players = [NSArray arrayWithArray:parsedPlayers];
        [self.tableView reloadData];
    } error:NULL];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellLeagueIdentifier];
    NSUInteger row = indexPath.row;
    [cell setPlayer:[self.players objectAtIndex:row] position:row total:self.players.count];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerEntity *player = [self.players objectAtIndex:indexPath.row];
    UserDetailVC *userDetailVC = [[UserDetailVC alloc] initWithPlayer:player];
    [self.navigationController pushViewController:userDetailVC animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Refresh Control
- (void)initializeRefreshControl
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshContent:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)refreshContent:(UIRefreshControl *)refresh
{
    [self reloadData];

    [refresh endRefreshing];
}

@end
