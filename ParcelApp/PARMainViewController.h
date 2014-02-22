//
//  PARMainViewController.h
//  ParcelApp
//
//  Created by Cezary Wojcik on 2/22/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "PARBannerViewController.h"

@interface PARMainViewController : UIViewController

- (IBAction)parcelButtonPressed:(UIButton *)sender;
- (IBAction)currentPositionButtonPressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) PARBannerViewController *bannerViewController;

@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIButton *parcelLocationButton;

@end
