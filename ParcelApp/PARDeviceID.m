//
//  PARDeviceID.m
//  ParcelApp
//
//  Created by Cezary Wojcik on 2/22/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import "PARDeviceID.h"

@implementation PARDeviceID

@synthesize deviceID;

- (PARDeviceID*)init
{
    self = [super init];
    if (self) {
        // set default values
        [self setup];
    }
    return self;
}

- (void)setup
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:DEVICE_ID_KEY]) {
        // create new device key
        self.deviceID = [[NSUUID UUID] UUIDString];;
        [[NSUserDefaults standardUserDefaults] setObject:self.deviceID forKey:DEVICE_ID_KEY];
    } else {
        // recall old device key
        self.deviceID = [[NSUserDefaults standardUserDefaults] objectForKey:DEVICE_ID_KEY];
    }
    NSLog(@"PAR Device ID: %@", self.deviceID);
}

@end
