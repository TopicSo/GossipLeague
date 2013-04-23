//
//  ComperatorViewController.m
//  GossipLeague
//
//  Created by Valenti on 23/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "ComperatorVC.h"
#import "ComperatorCell.h"
#import "PlayerEntity.h"
#import "ComperatorDetailVC.h"

@interface ComperatorVC ()

@property (nonatomic,strong) IBOutlet UITableView   *tableViewPlayer1;
@property (nonatomic,strong) IBOutlet UITableView   *tableViewPlayer2;
@property (nonatomic,strong) NSMutableArray         *playersArray;

//Entities
@property (nonatomic,strong) PlayerEntity           *playerSelected1;
@property (nonatomic,strong) PlayerEntity           *playerSelected2;

@end

@implementation ComperatorVC

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
    self.title = @"Comperator";
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Compare" style:UIBarButtonItemStyleBordered target:self action:@selector(goToResult:)];
    [self.navigationItem setRightBarButtonItem:barButton];
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
    [self.tableViewPlayer1 reloadData];
    [self.tableViewPlayer2 reloadData];
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
        [self.tableViewPlayer1 reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableViewPlayer2 reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];

    } error:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)goToResult:(id)sender
{
    UIAlertView *alert;
    if (self.playerSelected1 == nil)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Hey!" message:@"Player 1 not selected" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else if (self.playerSelected2 == nil)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Hey!" message:@"Player 2 not selected" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else if (self.playerSelected1 == self.playerSelected2)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Hey!" message:@"Forever alone!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }else
    {
        ComperatorDetailVC *comperatorDetailVC = [[ComperatorDetailVC alloc] initWithNibName:@"ComperatorDetailVC" bundle:nil player1:self.playerSelected1 player2:self.playerSelected2];
        [self.navigationController pushViewController:comperatorDetailVC animated:YES];
    }
}


#pragma mark - TV delegate & dataSource

#pragma mark -
#pragma mark Table view methods

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
    static NSString *CellIdentifier = @"ComperatorCell";
	
    ComperatorCell *cell = (ComperatorCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ComperatorCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects)
        {
			if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
				cell =  (ComperatorCell *) currentObject;
				break;
			}
		}
	}
    PlayerEntity *player =[self.playersArray objectAtIndex:indexPath.row];
    
    [cell setPlayerToCell:player];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableViewPlayer1)
    {
        self.playerSelected1 = [self.playersArray objectAtIndex:indexPath.row];
    }
    else
    {
        self.playerSelected2 = [self.playersArray objectAtIndex:indexPath.row];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
