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
        [self getParcelLocation];
    }
    return self;
}

- (void)getParcelLocation
{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[self getLocateParcelsURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError;
        NSArray *locationsFromServer = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&jsonError];
        self.locations = locationsFromServer;
        NSLog(@"JSON data: %@", locationsFromServer);
    }] resume];
}

- (NSURL*)getLocateParcelsURL
{
    NSString *urlString = [NSString stringWithFormat:@"%@locateparcels", SERVER_URL_STRING];
    return [NSURL URLWithString:urlString];
}

- (NSURL*)getDropParcelURLWithLatitude:(NSString*)latitude
                             Longitude:(NSString*)longitude
{
    NSString *urlString = [NSString stringWithFormat:@"%@dropparcel?latitude=%@&longitude=%@&groupid=1",
                           SERVER_URL_STRING, latitude, longitude];
    return [NSURL URLWithString:urlString];
}

@end
