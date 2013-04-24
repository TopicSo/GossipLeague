//
//  UIFont+Common.m
//  GossipLeague
//
//  Created by Oriol Blanc on 25/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "UIFont+Common.h"

@implementation UIFont (Common)

+ (UIFont *)fontForUsernameInCell
{
    return [UIFont fontWithName:@"FreightSans-Bold" size:18.0];
}

+ (UIFont *)fontForDateInCell
{
    return [UIFont fontWithName:@"FreightSans-LightSC" size:18.0];
}

+ (UIFont *)fontForGoalsInCell
{
    return [UIFont fontWithName:@"AlfaSlabOne-Regular" size:23.0];
}

@end
