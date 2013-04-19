#import "GossipLeagueVC.h"
#import <Parse/Parse.h>
#import <Parse/PFQueryTableViewController.h>
#import "TableCell.h"
#import "PlayerEntity.h"
#import "UserDetailVC.h"

@interface GossipLeagueVC () <UITableViewDataSource, UIAccelerometerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *players;

- (void)setUp;

@end

@implementation GossipLeagueVC

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Liga Gossip HUB";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeRefreshControl];
    [self setUp];
}

- (void)setUp
{
    OBRequest *request = [OBRequest requestWithType:OBRequestMethodTypeMethodGET resource:@"players/ranking" parameters:nil isPublic:YES];
    
    [OBConnection makeRequest:request success:^(id data, BOOL cached) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *tmpPlayer in [data objectForKey:@"players"]) {
            PlayerEntity *player = [[PlayerEntity alloc] initWithDictionary:tmpPlayer];
            [array addObject:player];
        }
        
        self.players = [NSArray arrayWithArray:array];
        
        [self.tableView reloadData];
        
    } error:NULL];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableLeagueCell";
    
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        UINib *cellNib = [UINib nibWithNibName:@"TableCell" bundle:nil];
        cell = [[cellNib instantiateWithOwner:self options:nil] objectAtIndex:0];
    }
    
    [cell setPlayer:[self.players objectAtIndex:indexPath.row] position:indexPath.row total:self.players.count];
    
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
