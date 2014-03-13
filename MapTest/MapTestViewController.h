//
//  MapTestViewController.h
//  MapTest
//
//  Created by won liao on 2014/3/13.
//  Copyright (c) 2014年 won liao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapTestViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *posLabel;




@end
