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

// Step 1
@property (weak, nonatomic) IBOutlet UIView *step1View;
@property (weak, nonatomic) IBOutlet UILabel *step1TitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *localTableView;

// Step 2
@property (weak, nonatomic) IBOutlet UIView *step2View;
@property (weak, nonatomic) IBOutlet UILabel *step2TitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *visitorTableView;

// Step 3
@property (weak, nonatomic) IBOutlet UIView *step3View;

@property (strong, nonatomic) NSArray *players;

@end

@implementation AddGameVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add";
    
    [self.localTableView registerNib:[UINib nibWithNibName:@"PlayerBasicCell" bundle:nil]
              forCellReuseIdentifier:CellLeagueIdentifier];
    [self.visitorTableView registerNib:[UINib nibWithNibName:@"PlayerBasicCell" bundle:nil]
              forCellReuseIdentifier:CellLeagueIdentifier];
    
    self.view.backgroundColor = [UIColor colorWinCard];
    self.step1View.backgroundColor = [UIColor colorBackgroundTableView];
    self.step2View.backgroundColor = [UIColor colorBackgroundTableView];
    self.step3View.backgroundColor = [UIColor colorBackgroundTableView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id) [[UIColor colorWithWhite:0 alpha:0.01] CGColor], (id) [[UIColor colorWithWhite:0 alpha:0.1] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    self.view.backgroundColor = [UIColor colorWinCard];
    
    self.step1TitleLabel.font = [UIFont fontForUsernameInCell];
    self.step1TitleLabel.textColor = [UIColor colorWinLabel];
    self.step2TitleLabel.font = [UIFont fontForUsernameInCell];
    self.step2TitleLabel.textColor = [UIColor colorWinLabel];
    
    [self setUpStep1];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.localTableView)
    {
        [self goToStep2:YES];
    }
    else
    {
        [self goToStep3:YES];
    }
}

#pragma mark - Steps

- (void)setUpStep1
{
    self.step1TitleLabel.text = @"Select the local player:";
}

- (void)goToStep1:(BOOL)animated
{
    [UIView transitionFromView:self.step2View toView:self.step1View duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        
    }];
}

- (void)setUpStep2
{
    self.step2TitleLabel.text = @"Select the visitor player:";
}

- (void)goToStep2:(BOOL)animated
{
    [self setUpStep2];
    
    [UIView transitionFromView:self.step1View toView:self.step2View duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
    }];
}

- (void)setUpStep3
{
}

- (void)goToStep3:(BOOL)animated
{
    [self setUpStep3];
    
    [UIView transitionFromView:self.step2View toView:self.step3View duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setStep1TitleLabel:nil];
    [self setLocalTableView:nil];
    [self setVisitorTableView:nil];
    [self setStep1View:nil];
    [self setStep2View:nil];
    [self setStep2TitleLabel:nil];
    [self setStep3View:nil];
    [super viewDidUnload];
}
@end
