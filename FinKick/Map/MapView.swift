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
    var kickboardUse : Int = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let startButton = UIButton()
    
    func mapStartButton(){
        startButton.setTitle("사용 시작", for: .normal)
        startButton.backgroundColor = .gray
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(startButton)
        
        let safeArea =  view.safeAreaLayoutGuide
        
        startButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 80).isActive = true
        startButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
        startButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -80).isActive = true
    }
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
        marker.width = 20
        marker.height = 20
        marker.mapView = mapView.mapView
        
        // 정보창 생성
        let infoWindow = NMFInfoWindow()
        let dataSource = NMFInfoWindowDefaultTextSource.data()
        dataSource.title = "영남이공대"
        infoWindow.dataSource = dataSource
        
        // 마커에 달아주기
        infoWindow.open(with: marker)

    }
    
    func mapCreate(){
        print("지도 뷰로드")
        
        //네이버 맵
        let mapView = NMFNaverMapView(frame: CGRect(x: 0, y: 0, width: appDelegate.width ?? 390, height: appDelegate.height ?? 722))
        print(appDelegate.width)
        print(appDelegate.height)
        mapView.mapView.positionMode = .direction

        //locationManager 인스턴스 생성 및 델리게이트 생성
        let locationManager = CLLocationManager()
        locationManager.delegate = self
//
//        //포그라운드 상태에서 위치 추적 권한 요청
//        locationManager.requestWhenInUseAuthorization()
//
//        //배터리에 맞게 권장되는 최적의 정확도
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//
//        //위치업데이트
//        locationManager.startUpdatingLocation()
        
        //위도 경도 가져오기
        var coor = locationManager.location?.coordinate
        latitude = coor?.latitude ??  35.8471267472791
        longitude = coor?.longitude ??  128.58281776895694
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude))
        mapView.mapView.moveCamera(cameraUpdate)
        
        mapView.showCompass = true
        mapView.showScaleBar = true
        mapView.showZoomControls = true
        mapView.showLocationButton = true
        mapView.mapView.logoInteractionEnabled = true
        mapView.mapView.logoAlign = NMFLogoAlign(rawValue: 0)!
        
        setMarker(mapView)
        
        view.addSubview(mapView)
        
        appDelegate.GetUseHistory(type: "ALL", num: nil){
            (data, result) in
            if let data = data{
                if data.result_data != nil {
                    for i in 0 ... (data.result_data?.useHistory!.count)!-1 {
                        do{
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            guard let startTime = dateFormatter.date(from:(data.result_data?.useHistory![i].startTime)!) else {return}
                            print(data.result_data?.useHistory![i].endTime)
                            guard let endTime = dateFormatter.date(from: (data.result_data?.useHistory![i].endTime) ?? "0000-00-00 00:00:00" ) else {return}
                            var useTime = Int(endTime.timeIntervalSince(startTime))
                            var useTimeMin = useTime / 60
                            var useTimeSec = useTime % 60
                                
                            let useTimeString = String(useTimeMin) + " 분 " + String(useTimeSec) + " 초"
                            print(useTimeString)
                            let money = data.result_data?.useHistory![i].price!
                            
                            Memo.dummyMemoList.append(Memo(content: (data.result_data?.useHistory![i].startTime)!, time: useTimeString, money: money! ,insertDate: endTime, num: (data.result_data?.useHistory![i].num)!))

                            print("여기가 유즈 히스토리 : ",data.result_data?.useHistory![i] as Any)
                        }catch{
                            print("실패")
                        }
                    }
                }
            }
        }
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

    override func viewDidLoad() {
        super.viewDidLoad()
        mapCreate()
        if kickboardUse == 0{
            mapStartButton()
            startButton.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
            }
    }
    
    @objc func btnOnClick(_ sender : Any?){
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "QRCode") else{
            return
        }
        // 전체 화면으로 불러옴
        uvc.modalPresentationStyle = .fullScreen
        //화면 전환 애니메이션을 설정합니다.
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출합니다.
        self.present(uvc, animated: true)
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

