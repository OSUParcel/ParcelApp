//
//  PARParcelHandler.h
//  ParcelApp
//
//  Created by Cezary Wojcik on 2/22/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define SERVER_URL_STRING @"https://parcelserver.appspot.com/"

@interface PARParcelHandler : NSObject

- (void)loadParcelLocation;
- (CLLocationCoordinate2D)getCurrentParcelLocation;

@property (strong, nonatomic) NSArray *locations;

@end
