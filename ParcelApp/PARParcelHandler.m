//
//  PARParcelHandler.m
//  ParcelApp
//
//  Created by Cezary Wojcik on 2/22/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import "PARParcelHandler.h"

@implementation PARParcelHandler

@synthesize locations;

- (PARParcelHandler*)init
{
    self = [super init];
    if (self) {
        [self loadParcelLocation];
    }
    return self;
}

- (void)loadParcelLocation
{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[self getLocateParcelsURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError;
        NSArray *locationsFromServer = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&jsonError];
        self.locations = locationsFromServer;
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
    return CLLocationCoordinate2DMake(latitude, longitude);
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

@end
