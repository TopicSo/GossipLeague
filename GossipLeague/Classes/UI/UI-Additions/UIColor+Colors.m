//
//  UIColor+Colors.m
//  GossipLeague
//
//  Created by Oriol Blanc on 24/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "UIColor+Colors.h"

@implementation UIColor (Colors)

+ (UIColor *)colorBackgroundTableView
{
    return [UIColor colorWithRed:53/255.0 green:39/255.0 blue:35/255.0 alpha:1.0];
}

+ (UIColor *)colorTopShadowCell
{
    return [UIColor colorWithRed:63/255.0 green:50/255.0 blue:46/255.0 alpha:1.0];
}

+ (UIColor *)colorBottomShadowCell
{
    return [UIColor colorWithRed:39/255.0 green:28/255.0 blue:25/255.0 alpha:1.0];
}

+ (UIColor *)colorWinCard
{
    return [UIColor colorWithRed:54/255.0 green:155/255.0 blue:93/255.0 alpha:1.0];
}

+ (UIColor *)colorLostCard
{
    return [UIColor colorWithRed:215/255.0 green:78/255.0 blue:24/255.0 alpha:1.0];
}

+ (UIColor *)colorDrawCard
{
    return [UIColor colorWithRed:156/255.0 green:155/255.0 blue:68/255.0 alpha:1.0];
}

+ (UIColor *)colorWinLabel
{
    return [UIColor colorWithRed:108/255.0 green:196/255.0 blue:115/255.0 alpha:1.0];
}

+ (UIColor *)colorLostLabel
{
    return [UIColor colorWithRed:255/255.0 green:173/255.0 blue:140/255.0 alpha:1.0];
}

+ (UIColor *)colorDrawLabel
{
    return [UIColor colorWithRed:224/255.0 green:223/255.0 blue:155/255.0 alpha:1.0];
}

@end
