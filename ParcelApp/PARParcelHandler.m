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
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [completion invoke];
        }];
    }] resume];
}

- (void)pickupParcelWithCompletion:(void (^)(void))completion
{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[self getPickupParcelURLForGroupID:GROUP_ID] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self loadParcelLocationWithCompletion:nil];
        NSError *jsonError;
        NSArray *result = [NSJSONSerialization JSONObjectWithData:data
                                                          options:NSJSONReadingAllowFragments
                                                            error:&jsonError];
        NSString *message = [(NSDictionary*)result[0] objectForKey:@"message"];
        if (![message isEqualToString:@"success"]) {
            [self displayError:message];
            NSLog(@"error: %@", message);
        } else {
            if (![[NSUserDefaults standardUserDefaults] objectForKey:PICKEDUP_KEY]) {
                // create new device key
                [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:PICKEDUP_KEY];
            }
        }
        
        [completion invoke];
    }] resume];
}

- (void)dropParcelWithLatitude:(NSString*)latitude Longitude:(NSString*)longitude Completion:(void (^)(void))completion
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if ([[NSUserDefaults standardUserDefaults] objectForKey:PICKEDUP_KEY]) {
            NSURLSession *session = [NSURLSession sharedSession];
            [[session dataTaskWithURL:[self getDropParcelURLWithLatitude:latitude Longitude:longitude GroupID:GROUP_ID Note:@""] completionHandler:^(NSData *data,  NSURLResponse *response, NSError *error) {
                [self loadParcelLocationWithCompletion:nil];
                NSError *jsonError;
                NSArray *result = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:NSJSONReadingAllowFragments
                                                                    error:&jsonError];
                NSString *message = [(NSDictionary*)result[0] objectForKey:@"message"];
                if (![message isEqualToString:@"success"]) {
                    [self performSelectorOnMainThread:@selector(displayError:) withObject:message waitUntilDone:YES];
                }
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:PICKEDUP_KEY];
                [completion invoke];
            }] resume];
        }
    }];
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

- (void)displayError:(NSString*)message
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
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
