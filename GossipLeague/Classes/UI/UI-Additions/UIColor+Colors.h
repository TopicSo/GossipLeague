//
//  UIColor+Colors.h
//  GossipLeague
//
//  Created by Oriol Blanc on 24/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Colors)

+ (UIColor *)colorBackgroundTableView;
+ (UIColor *)colorTopShadowCell;
+ (UIColor *)colorBottomShadowCell;

// card colors
+ (UIColor *)colorWinCard;
+ (UIColor *)colorLostCard;
+ (UIColor *)colorDrawCard;

// label colors
+ (UIColor *)colorWinLabel;
+ (UIColor *)colorLostLabel;
+ (UIColor *)colorDrawLabel;
@end
