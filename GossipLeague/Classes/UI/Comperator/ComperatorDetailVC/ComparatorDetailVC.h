//
//  ComparatorDetailVC.h
//  GossipLeague
//
//  Created by Valenti on 23/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerEntity;

@interface ComparatorDetailVC : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil player1:(PlayerEntity*)player1_ player2:(PlayerEntity*)player2_;

@end
