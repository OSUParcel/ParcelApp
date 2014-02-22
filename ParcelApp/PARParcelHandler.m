//
//  PARParcelHandler.m
//  ParcelApp
//
//  Created by Cezary Wojcik on 2/22/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import "PARParcelHandler.h"
#import "AppDelegate.h"

@implementation PARParcelHandler

@synthesize locations;

- (PARParcelHandler*)init
{
    self = [super init];
    if (self) {
        [self loadParcelLocationWithCompletion:nil];
    }
    return self;
}

- (void)loadParcelLocationWithCompletion:(void (^)(void))completion
{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[self getLocateParcelsURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError;
        NSArray *locationsFromServer = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&jsonError];
        self.locations = locationsFromServer;
        [completion invoke];
    }] resume];
}

- (CLLocationCoordinate2D)getCurrentParcelLocation
{
    NSString *latitudeString = [((NSDictionary*)[self.locations objectAtIndex:0]) objectForKey:@"Latitude"];
    NSString *longitudeString = [((NSDictionary*)[self.locations objectAtIndex:0]) objectForKey:@"Longitude"];
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    CLLocationDegrees latitude = [[formatter numberFromString:latitudeString] doubleValue];
    CLLocationDegrees longitude = [[formatter numberFromString:longitudeString] doubleValue];
    NSLog(@"lat: %f, long: %f", latitude, longitude);
    return CLLocationCoordinate2DMake(longitude, latitude);
}

// ---- [ urls ] ---------------------------------------------------------------------------

- (NSURL*)getLocateParcelsURL
{
    NSString *urlString = [NSString stringWithFormat:@"%@locateparcels", SERVER_URL_STRING];
    return [NSURL URLWithString:urlString];
}

- (NSURL*)getDropParcelURLWithLatitude:(NSString*)latitude
                             Longitude:(NSString*)longitude
                               GroupID:(NSString*)groupID
                                  Note:(NSString*)note
{
    NSString *urlString = [NSString stringWithFormat:@"%@dropparcel?latitude=%@&longitude=%@&groupid=%@&note=%@",
                           SERVER_URL_STRING, latitude, longitude, groupID, note];
    return [NSURL URLWithString:urlString];
}

- (NSURL*)getPickupParcelURLForGroupID:(NSString*)groupID
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlString = [NSString stringWithFormat:@"%@pickupparcel?userid=%@&groupid=%@",
                           SERVER_URL_STRING, delegate.deviceID.deviceID, groupID];
    return [NSURL URLWithString:urlString];
}


@end
