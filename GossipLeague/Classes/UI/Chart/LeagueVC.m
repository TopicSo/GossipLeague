#import "LeagueVC.h"
#import <Parse/Parse.h>
#import <Parse/PFQueryTableViewController.h>
#import "PlayerBasicCell.h"
#import "PlayerEntity.h"
#import "RankingEntity.h"
#import "UserDetailVC.h"

static NSString * const CellLeagueIdentifier = @"PlayerBasicCell";

@interface LeagueVC () <UITableViewDataSource, UIAccelerometerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) RankingEntity *ranking;
- (void)reloadData;

@end

@implementation LeagueVC

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Liga Topic HUB";
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
    NSString *resource = @"players/ranking?divisions=true";
    OBRequest *request = [OBRequest requestWithType:OBRequestMethodTypeMethodGET resource:resource parameters:nil isPublic:YES];
    
    [OBConnection makeRequest:request withCacheKey:resource parseBlock:^id(NSDictionary *data) {
        
        RankingEntity *ranking = [MTLJSONAdapter modelOfClass:[RankingEntity class] fromJSONDictionary:data error:nil];
        
        return ranking;
    } success:^(RankingEntity *ranking, BOOL cached) {
        self.ranking = ranking;
        [self.tableView reloadData];
        
        [self.refreshControl endRefreshing];
    } error:NULL];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.ranking.countDivisions;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *players = section == 0 ? self.ranking.rankedPlayers : self.ranking.unclassifiedPlayers;
    
    return players.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PlayerBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellLeagueIdentifier];
    
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    
    if (section == 0)
    {
        [cell setPlayer:[self.ranking.rankedPlayers objectAtIndex:row] position:row total:self.ranking.rankedPlayers.count];
    }
    else
    {
        [cell setPlayer:[self.ranking.unclassifiedPlayers objectAtIndex:row]];

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *players = indexPath.section == 0 ? self.ranking.rankedPlayers : self.ranking.unclassifiedPlayers;
    PlayerEntity *player = [players objectAtIndex:indexPath.row];
    UserDetailVC *userDetailVC = [[UserDetailVC alloc] initWithPlayer:player];
    [self.navigationController pushViewController:userDetailVC animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Ranking";
    }
    else
    {
        return [NSString stringWithFormat:@"Unclassified: Less than %d games", self.ranking.breakEvenPoint];
    }
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Refresh Control
- (void)initializeRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshContent:) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshContent:(UIRefreshControl *)refresh
{
    [self reloadData];
}

@end
