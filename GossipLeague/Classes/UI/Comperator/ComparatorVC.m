//
//  ComparatorViewController.m
//  GossipLeague
//
//  Created by Valenti on 23/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "ComparatorVC.h"
#import "PlayerBasicCell.h"
#import "PlayerEntity.h"
#import "ComparatorDetailVC.h"

@interface ComparatorVC ()

@property (nonatomic,strong) IBOutlet UITableView   *playerTable;
@property (nonatomic,strong) NSMutableArray         *playersArray;

@end

@implementation ComparatorVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Comparator";
    self.playerTable.backgroundColor = [UIColor colorBackgroundTableView];
    [self initializeRefreshControl];
    [self reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.playersArray removeAllObjects];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.playerTable reloadData];
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
    } success:^(NSArray *parsedPlayers, BOOL cached)
    {
        self.playersArray = [NSArray arrayWithArray:parsedPlayers];
        if (!cached) {
            [self.playerTable reloadData];
        }
    } error:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TV delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
    return [self.playersArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlayerBasicCell";
	
    PlayerBasicCell *cell = (PlayerBasicCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PlayerBasicCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects)
        {
			if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
				cell =  (PlayerBasicCell *) currentObject;
				break;
			}
		}
	}
    PlayerEntity *player =[self.playersArray objectAtIndex:indexPath.row];
    
    [cell setPlayer:player];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *selectedRows = [tableView indexPathsForSelectedRows];
    if (selectedRows.count == 2) {
        NSIndexPath *index1 = [selectedRows objectAtIndex:0];
        NSIndexPath *index2 = [selectedRows objectAtIndex:1];
        
        PlayerEntity *player1 = [self.playersArray objectAtIndex:index1.row];
        PlayerEntity *player2 =[self.playersArray objectAtIndex:index2.row];
        
        ComparatorDetailVC *comparatorDetailVC = [[ComparatorDetailVC alloc] initWithNibName:@"ComparatorDetailVC" bundle:nil player1:player1 player2:player2];
        [self.navigationController pushViewController:comparatorDetailVC animated:YES];
    }
}

#pragma mark - Refresh Control
- (void)initializeRefreshControl
{
    // Initialize Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    // Configure Refresh Control
    [refreshControl addTarget:self action:@selector(refreshContent:) forControlEvents:UIControlEventValueChanged];
    // Configure View Controller
    [self.playerTable addSubview:refreshControl];
}

- (void)refreshContent:(UIRefreshControl *)refresh
{
    [self reloadData];
    [refresh endRefreshing];
}

@end
