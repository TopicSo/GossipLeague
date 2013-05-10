//
//  AddGameVC.m
//  GossipLeague
//
//  Created by Oriol Blanc on 09/05/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "AddGameVC.h"
#import <QuartzCore/QuartzCore.h>
#import "PlayerEntity.h"
#import "PlayerBasicCell.h"

static NSString * const CellLeagueIdentifier = @"PlayerBasicCell";

@interface AddGameVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITableView *localTableView;
@property (strong, nonatomic) IBOutlet UITableView *visitorTableView;
@property (strong, nonatomic) NSArray *players;
@end

@implementation AddGameVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.localTableView registerNib:[UINib nibWithNibName:@"PlayerBasicCell" bundle:nil]
              forCellReuseIdentifier:CellLeagueIdentifier];
    [self.visitorTableView registerNib:[UINib nibWithNibName:@"PlayerBasicCell" bundle:nil]
              forCellReuseIdentifier:CellLeagueIdentifier];
    
    self.view.backgroundColor = [UIColor colorBackgroundTableView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id) [[UIColor colorWithWhite:0 alpha:0.01] CGColor], (id) [[UIColor colorWithWhite:0 alpha:0.1] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    [self reloadData];
}

- (void)reloadData
{
    OBRequest *request = [OBRequest requestWithType:OBRequestMethodTypeMethodGET resource:@"players" parameters:nil isPublic:YES];
    
    [OBConnection makeRequest:request withCacheKey:NSStringFromClass([self class]) parseBlock:^id(NSDictionary *data) {
        NSMutableArray *parsedPlayers = [NSMutableArray array];
        
        for (NSDictionary *tmpPlayer in [data objectForKey:@"players"]) {
            PlayerEntity *player = [MTLJSONAdapter modelOfClass:[PlayerEntity class] fromJSONDictionary:tmpPlayer error:nil];
            [parsedPlayers addObject:player];
        }
        
        return parsedPlayers;
    } success:^(NSArray *parsedPlayers, BOOL cached) {
        self.players = [NSArray arrayWithArray:parsedPlayers];
        [self.localTableView reloadData];
        [self.visitorTableView reloadData];
        
    } error:NULL];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellLeagueIdentifier];
    NSUInteger row = indexPath.row;
    [cell setPlayer:[self.players objectAtIndex:row]];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setLocalTableView:nil];
    [self setVisitorTableView:nil];
    [super viewDidUnload];
}
@end
