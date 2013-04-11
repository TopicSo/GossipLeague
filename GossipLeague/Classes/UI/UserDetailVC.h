//
//  UserDetailVC.h
//  GossipLeague
//
//  Created by Oriol Blanc on 10/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerEntity;
@interface UserDetailVC : UIViewController

- (id)initWithPlayer:(PlayerEntity *)player;

@end
