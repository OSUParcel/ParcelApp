//
//  AppDelegate.h
//  ParcelApp
//
//  Created by Cezary Wojcik on 2/22/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PARDeviceID.h"
#import "PARParcelHandler.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PARDeviceID *deviceID;
@property (strong, nonatomic) PARParcelHandler *parcelHandler;

@end
