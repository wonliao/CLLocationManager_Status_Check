//
//  MapTestViewController.m
//  MapTest
//
//  Created by won liao on 2014/3/13.
//  Copyright (c) 2014年 won liao. All rights reserved.
//

#import "MapTestViewController.h"


@interface MapTestViewController ()

@end

@implementation MapTestViewController {
 IBOutlet __weak MKMapView *_mapView;
 IBOutlet __weak UIButton *_getLocationButton;
 __strong CLLocationManager *_locationManager;
 __strong NSDate *_startUpdatingLocationAt;
}

@synthesize posLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    [_getLocationButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [_getLocationButton addTarget:self action:@selector(didTapGetLocationButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapGetLocationButton
{
    /*
    // 也可以事先檢查，
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (!((status == kCLAuthorizationStatusNotDetermined) ||
          (status == kCLAuthorizationStatusAuthorized))) {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"請至iOS的設定>隱私，並開啟定位服務，使應用程序能訪問您的位置。"
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
        return;
    }
    */
    
    [_locationManager startUpdatingLocation];
    
    _getLocationButton.enabled = NO;
    _startUpdatingLocationAt = [NSDate date];
    
    NSLog(@"Start updating location. timestamp:%@", [[NSDate date] description]);
}

#pragma mark - CLLocationManagerDelegate

// 錯誤
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [_locationManager stopUpdatingLocation];
    
    _getLocationButton.enabled = YES;
    
    [[[UIAlertView alloc] initWithTitle:nil
                                message:@"請至iOS的設定>隱私，並開啟定位服務，使應用程序能訪問您的位置。"
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"OK", nil] show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *recentLocation = locations.lastObject;
    if (recentLocation.timestamp.timeIntervalSince1970 < _startUpdatingLocationAt.timeIntervalSince1970) {
        // Ignore old location.
        return;
    }
    
    [_locationManager stopUpdatingLocation];
    
    _getLocationButton.enabled = YES;
    
    [_mapView setCenterCoordinate:recentLocation.coordinate animated:YES];
    
    MKPointAnnotation *mapAnnotation = [[MKPointAnnotation alloc] init];
    mapAnnotation.coordinate = recentLocation.coordinate;
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotation:mapAnnotation];
    
    NSLog(@"Updated location:%f %f timestamp:%@", recentLocation.coordinate.latitude, recentLocation.coordinate.longitude, recentLocation.timestamp.description);
    
    [posLabel setText:[NSString stringWithFormat:@"%f %f", recentLocation.coordinate.latitude, recentLocation.coordinate.longitude]];
}


@end
