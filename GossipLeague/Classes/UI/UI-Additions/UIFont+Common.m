//
//  UIFont+Common.m
//  GossipLeague
//
//  Created by Oriol Blanc on 25/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "UIFont+Common.h"

@implementation UIFont (Common)

#pragma mark - Cells

+ (UIFont *)fontForUsernameInCell
{
    return [UIFont fontWithName:@"FreightSansBold" size:18.0];
}

+ (UIFont *)fontForDateInCell
{
    return [UIFont fontWithName:@"FreightSansLightSC" size:10.0];
}

+ (UIFont *)fontForGoalsInCell
{
    return [UIFont fontWithName:@"AlfaSlabOne-Regular" size:21.0];
}

+ (UIFont *)fontForNavBarTitle
{
    return [UIFont fontWithName:@"AlfaSlabOne-Regular" size:17];
}
@end
