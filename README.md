CLLocationManager_Status_Check
==============================

CLLocationManager authorizationStatus Check


主要是要檢查是否已開啟定位服務
沒有的話，出現提示訊息


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
