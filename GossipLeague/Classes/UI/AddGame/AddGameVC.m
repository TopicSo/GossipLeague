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

@interface AddGameVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>

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
@property (weak, nonatomic) IBOutlet UILabel *localPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitorPlayerLabel;
@property (weak, nonatomic) IBOutlet UITextField *localGoalsTextField;
@property (weak, nonatomic) IBOutlet UITextField *visitorGoalsTextField;

@property (strong, nonatomic) NSArray *players;
@property (weak, nonatomic) PlayerEntity *local;
@property (weak, nonatomic) PlayerEntity *visitor;

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
    [cell setPlayer:[self.players objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.localTableView)
    {
        self.local = [self.players objectAtIndex:indexPath.row];
        [self goToStep2:YES];
    }
    else
    {
        if ([self.local isEqual:[self.players objectAtIndex:indexPath.row]]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"forever alone" delegate:self cancelButtonTitle:@"Sure" otherButtonTitles:nil];
            
            [alert show];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        else
        {
            self.visitor = [self.players objectAtIndex:indexPath.row];
            [self goToStep3:YES];
        }
    }
}

#pragma mark - Steps

- (void)setUpStep1
{
    self.step1TitleLabel.text = [@"local" uppercaseString];
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)goToStep1:(BOOL)animated
{
    [self setUpStep1];
    
    [UIView transitionFromView:self.step3View toView:self.step2View duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        
    }];
}

- (void)setUpStep2
{
    self.step2TitleLabel.text = [@"visitor" uppercaseString];
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)goToStep2:(BOOL)animated
{
    [self setUpStep2];
    
    [UIView transitionFromView:self.step1View toView:self.step2View duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
    }];
}

- (void)setUpStep3
{
    // local
    self.localPlayerLabel.text = self.local.username;
    self.localPlayerLabel.font = [UIFont fontForGoalsInCell];
    self.localGoalsTextField.font = [UIFont fontForGoalsInCell];
    self.localGoalsTextField.backgroundColor = [UIColor colorDrawCard];
    self.localGoalsTextField.layer.cornerRadius = 2.0f;
    
    // visitor
    self.visitorPlayerLabel.text = self.visitor.username;
    self.visitorPlayerLabel.font = [UIFont fontForGoalsInCell];
    self.visitorGoalsTextField.font = [UIFont fontForGoalsInCell];
    self.visitorGoalsTextField.backgroundColor = [UIColor colorDrawCard];
    self.visitorGoalsTextField.layer.cornerRadius = 2.0f;
    
    UIBarButtonItem *addGameBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGame)];
    self.navigationItem.rightBarButtonItem = addGameBarButtonItem;
}

- (void)goToStep3:(BOOL)animated
{
    [self setUpStep3];
    
    [UIView transitionFromView:self.step2View toView:self.step3View duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Actions

- (void)addGame
{
    NSString *message = [NSString stringWithFormat:@"%@ %@: %d %d", self.local.username, self.visitor.username, [self.localGoalsTextField.text intValue], [self.visitorGoalsTextField.text intValue]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    
    [alert show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != alertView.cancelButtonIndex)
    {
        NSLog(@"add game");
        OBRequestParameters *parameters = [OBRequestParameters emptyRequestParameters];
        [parameters setValue:self.local.username forKey:@"localPlayer"];
        [parameters setValue:self.visitor.username forKey:@"visitorPlayer"];
        [parameters setValue:self.localGoalsTextField.text forKey:@"localGoals"];
        [parameters setValue:self.visitorGoalsTextField.text forKey:@"visitorGoals"];
        
        OBRequest *request = [OBRequest requestWithType:OBRequestMethodTypeMethodPOST resource:@"games" parameters:parameters isPublic:YES];
        
        [OBConnection makeRequest:request success:^(id data, BOOL cached) {
            NSLog(@"success");
        } error:^(id data, NSError *error) {
            NSLog(@"error");
        }];
    }
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *goals = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    UITextField *otherTextField = textField == self.localGoalsTextField ? self.visitorGoalsTextField : self.localGoalsTextField;

    if([goals intValue] == [otherTextField.text intValue])
    {
        textField.backgroundColor = [UIColor colorDrawCard];
        otherTextField.backgroundColor = [UIColor colorDrawCard];
    }
    else if([goals intValue] > [otherTextField.text intValue])
    {
        textField.backgroundColor = [UIColor colorWinCard];
        otherTextField.backgroundColor = [UIColor colorLostCard];
    }
    else if([goals intValue] < [otherTextField.text intValue])
    {
        textField.backgroundColor = [UIColor colorLostCard];
        otherTextField.backgroundColor = [UIColor colorWinCard];
    }
    
    return YES;
}

#pragma mark - Memory Management

- (void)viewDidUnload
{
    [self setStep1TitleLabel:nil];
    [self setLocalTableView:nil];
    [self setVisitorTableView:nil];
    [self setStep1View:nil];
    [self setStep2View:nil];
    [self setStep2TitleLabel:nil];
    [self setStep3View:nil];
    [self setLocalPlayerLabel:nil];
    [self setVisitorPlayerLabel:nil];
    [self setLocalGoalsTextField:nil];
    [self setVisitorGoalsTextField:nil];
    [super viewDidUnload];
}

@end
