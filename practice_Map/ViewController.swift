//
//  ViewController.swift
//  practice_Map
//
//  Created by 中野湧仁 on 2018/12/27.
//  Copyright © 2018年 中野湧仁. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 緯度
        let ivalue = Float.random(in: 35 ... 36)
        
//        経度
        let kValue = Float.random(in: 138 ... 141)
        
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(ivalue), CLLocationDegrees(kValue))
        
        mapView.setCenter(location, animated: true)
        
        var region:MKCoordinateRegion = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        
        mapView.setRegion(region, animated: true)
        
        mapView.mapType = .hybrid
        
        mapView.delegate = self
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        annotation.title = "次の休みはここへ行け！"
        
        
        mapView.addAnnotation(annotation)
        
    }

    @IBAction func reload(_ sender: Any) {
        count += 1
        if (count == 1){
            
            mapView.mapType = .standard
            
        }else if (count == 2){
            
            mapView.mapType = .hybridFlyover
            
        }else if (count == 3){
            
            mapView.mapType = .mutedStandard
            
        }else if (count == 4){
            
            mapView.mapType = .satellite
            
        }else if (count == 5){
            
            mapView.mapType = .satelliteFlyover
            
        }else if (count == 6){
            
            mapView.mapType = .hybrid
            count = 0
            
        }
        
        
        
        
    }
    
    
    /**
     * @brief  スクリーンショットを取得する
     * @return UIImage
     */
    func getScreenShot()-> UIImage {
        // キャプチャ範囲を決定
        let width = Int(UIScreen.main.bounds.size.width)  //画面横幅いっぱい
        let height = 100
        let size = CGSize(width: width, height: height)
        // ビットマップ画像のcontextを作成
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        // 対象のview内の描画をcontextに複写する.
        self.view.layer.render(in: context)
        // 現在のcontextのビットマップをUIImageとして取得.
        let capturedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        // contextを閉じる.
        UIGraphicsEndImageContext()
        return capturedImage
    }

    
    
    
    
    @IBAction func Share(_ sender: Any) {
        // スクリーンショットを取得
        let shareImage = getScreenShot().jpegData(compressionQuality: 1.0)
        // 共有項目
        let activityItems: [Any] = [shareImage!, "私は次の休みにここに行くことを宣言致します　#次の休みはここに行け！"]
        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)
        
        
    }
}

