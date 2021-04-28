//
//  ViewController.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/01.
//

import UIKit
import NMapsMap
// 카카오
// public let DEFAULT_POSITION = MTMapPointGeo(latitude: 35.8471267472791, longitude: 128.58281776895694)

class MapView: UIViewController, MTMapViewDelegate {
    // 카카오
//    var mapView: MTMapView?
//    var mapPoint1: MTMapPoint?
//    var poiItem1: MTMapPOIItem?
//    var mapcricle: MTMapCircle?
    // 네이버
    func setMarker(_ mapView: NMFNaverMapView) {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
        marker.iconImage = NMF_MARKER_IMAGE_BLACK
        marker.iconTintColor = UIColor.red
        marker.width = 50
        marker.height = 60
        marker.mapView = mapView.mapView
        
        // 정보창 생성
        let infoWindow = NMFInfoWindow()
        let dataSource = NMFInfoWindowDefaultTextSource.data()
        dataSource.title = "서울특별시청"
        infoWindow.dataSource = dataSource
        
        // 마커에 달아주기
        infoWindow.open(with: marker)

    }
    
    override func viewDidLoad() {
        
            super.viewDidLoad()
        //네이버 맵
            var mapView = NMFNaverMapView(frame: view.frame)
            let locationOverlay = mapView.mapView.locationOverlay
            locationOverlay.hidden = true
            locationOverlay.icon = NMFOverlayImage(name: "location_overlay_icon")
            setMarker(mapView)
            mapView.mapView.positionMode = .direction
            mapView.showLocationButton = true
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

