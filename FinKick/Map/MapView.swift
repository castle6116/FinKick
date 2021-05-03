//
//  ViewController.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/01.
//

import UIKit
import NMapsMap
import CoreLocation
// 카카오
// public let DEFAULT_POSITION = MTMapPointGeo(latitude: 35.8471267472791, longitude: 128.58281776895694)

class MapView: UIViewController, MTMapViewDelegate, CLLocationManagerDelegate {
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    
    // 카카오
//    var mapView: MTMapView?
//    var mapPoint1: MTMapPoint?
//    var poiItem1: MTMapPOIItem?
//    var mapcricle: MTMapCircle?
    // 네이버
    func setMarker(_ mapView: NMFNaverMapView) {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 35.8471267472791, lng: 128.58281776895694)
        marker.iconImage = NMF_MARKER_IMAGE_BLACK
        marker.iconTintColor = UIColor.red
        marker.width = 50
        marker.height = 60
        marker.mapView = mapView.mapView
        
        // 정보창 생성
        let infoWindow = NMFInfoWindow()
        let dataSource = NMFInfoWindowDefaultTextSource.data()
        dataSource.title = "영남이공대"
        infoWindow.dataSource = dataSource
        
        // 마커에 달아주기
        infoWindow.open(with: marker)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //네이버 맵
        let mapView = NMFNaverMapView(frame: view.frame)
        mapView.mapView.positionMode = .normal
        
        //locationManager 인스턴스 생성 및 델리게이트 생성
        let locationManager = CLLocationManager()
        locationManager.delegate = self
            
        //포그라운드 상태에서 위치 추적 권한 요청
        locationManager.requestWhenInUseAuthorization()
        
        //배터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //위치업데이트
        locationManager.startUpdatingLocation()
        
        //위도 경도 가져오기
        var coor = locationManager.location?.coordinate
        latitude = coor!.latitude
        longitude = coor!.longitude
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude))
        mapView.mapView.moveCamera(cameraUpdate)
        
        mapView.showCompass = true
        mapView.showScaleBar = true
        mapView.showZoomControls = true
        mapView.showLocationButton = true
        mapView.mapView.logoInteractionEnabled = true
        mapView.mapView.logoAlign = NMFLogoAlign(rawValue: 3)!
        
//        setMarker(mapView)
        
        view.addSubview(mapView)
        //카카오 맵
//            // 지도 불러오기
//            mapView = MTMapView(frame: self.view.bounds)
//            if let mapView = mapView {
//                mapView.delegate = self
//                mapView.baseMapType = .standard
//
//                // 지도 중심점, 레벨
//                mapView.setMapCenter(MTMapPoint(geoCoord: DEFAULT_POSITION), zoomLevel: 1, animated: true)
//
//                // 현재 위치 트래킹
//                mapView.showCurrentLocationMarker = true
//                mapView.currentLocationTrackingMode = .onWithoutHeading
//
//                // 마커 추가
//                self.mapPoint1 = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 35.8471267472791, longitude: 128.58281776895694))
//                poiItem1 = MTMapPOIItem()
//                poiItem1?.markerType = MTMapPOIItemMarkerType.bluePin
//                poiItem1?.mapPoint = mapPoint1
//                poiItem1?.itemName = "영남이공대"
//                mapView.add(poiItem1)
//
//                // 원형 추가
//                mapcricle = MTMapCircle()
//                mapcricle?.circleCenterPoint = MTMapPoint(geoCoord: DEFAULT_POSITION)
//                mapcricle?.circleLineColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
//                mapcricle?.circleFillColor = UIColor(red: 0.815, green: 0.767, blue: 1.0, alpha: 0.7)
//                mapcricle?.tag = 1234;
//                mapcricle?.circleRadius = 30;
//                mapView.addCircle(mapcricle)
//
//                let button = UIButton(type: UIButton.ButtonType.custom)
//                let image = UIImage(named: "ic_main_location.png") as UIImage?
//                button.frame = CGRect(x: self.view.frame.size.width - 60, y: 100, width: 50, height: 50)
//                button.setImage(image, for: .normal)
//                button.addTarget(self, action: #selector(refreshMap), for: .touchUpInside)
//
//                self.view.addSubview(mapView)
//                self.view.addSubview(button)
//            }

        }
        
    // 카카오
//        // Custom: 현 위치 트래킹 함수
//        func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
//            let currentLocation = location?.mapPointGeo()
//            if let latitude = currentLocation?.latitude, let longitude = currentLocation?.longitude{
//                print("MTMapView updateCurrentLocation (\(latitude),\(longitude)) accuracy (\(accuracy))")
//            }
//        }
//
//        func mapView(_ mapView: MTMapView?, updateDeviceHeading headingAngle: MTMapRotationAngle) {
//            print("MTMapView updateDeviceHeading (\(headingAngle)) degrees")
//        }
//       @IBAction func refreshMap(){
//            mapView?.clearsContextBeforeDrawing
//            mapView?.refreshMapTiles()
//            mapView?.setMapCenter(MTMapPoint(geoCoord: DEFAULT_POSITION), zoomLevel: 1, animated: true)
//        }
}

