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
#define PICKEDUP_KEY @"PARPICKEDUP"

#define GROUP_ID @"1"

@interface PARParcelHandler : NSObject

- (void)loadParcelLocationWithCompletion:(void (^)(void))completion;
- (void)pickupParcelWithCompletion:(void (^)(void))completion;
- (void)dropParcelWithLatitude:(NSString*)latitude Longitude:(NSString*)longitude Completion:(void (^)(void))completion;
- (CLLocationCoordinate2D)getCurrentParcelLocation;
- (void)displayError:(NSString*)message;

@property (strong, nonatomic) NSArray *locations;

@end
