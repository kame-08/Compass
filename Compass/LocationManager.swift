//
//  LocationManager.swift
//  Compass
//
//  Created by Ryo on 2022/07/24.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    
//    @Published var region = MKCoordinateRegion()
    
    @Published var heading:CLLocationDirection = 0.0
    
    //    var gool1:CGFloat = 35.85694
    //    var gool2:CGFloat = 35.85694
    
    @Published var kakudo = 0
    
    let manager = CLLocationManager()
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        //電子コンパス設定
        manager.headingFilter = kCLHeadingFilterNone
        manager.headingOrientation = .portrait
        manager.startUpdatingHeading()
    }
    
    //電子コンパス値取得
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.heading = newHeading.magneticHeading
        //Lat緯度
        
//        kakudo = angle(currentLatitude: 35.766361, currentLongitude: 139.650611, targetLatitude: 35.766402, targetLongitude: 139.650894)
//        kakudo = angle(currentLatitude: region.center.latitude, currentLongitude: region.center.longitude, targetLatitude: 35.766402, targetLongitude: 139.650894)
//        print("lat\(region.center.latitude)")
//        print("lon\(region.center.longitude)")
  
    }
    
    //TODO: - ここから角度
    
    
    // 基準地の緯度経度から目的地の緯度経度の方角を計算する
    func angle(currentLatitude: CGFloat, currentLongitude: CGFloat, targetLatitude: CGFloat, targetLongitude: CGFloat) -> Int {
        
        let currentLatitude     = toRadian(currentLatitude)
        let currentLongitude    = toRadian(currentLongitude)
        let targetLatitude      = toRadian(targetLatitude)
        let targetLongitude     = toRadian(targetLongitude)
        
        let difLongitude = targetLongitude - currentLongitude
        let y = sin(difLongitude)
        let x = cos(currentLatitude) * tan(targetLatitude) - sin(currentLatitude) * cos(difLongitude)
        let p = atan2(y, x) * 180 / CGFloat.pi
        
        if p < 0 {
            return Int(360 + atan2(y, x) * 180 / CGFloat.pi)
        }
        return Int(atan2(y, x) * 180 / CGFloat.pi)
    }
    
    // 角度からラジアンに変換
    func toRadian(_ angle: CGFloat) -> CGFloat {
        return angle * CGFloat.pi / 180
    }
    
}
