//
//  GossipGamesVC.h
//  GossipLeague
//
//  Created by Giuseppe Basile on 19/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamesVC : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *games;

@end
