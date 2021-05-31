//
//  QRCheck.swift
//  FinKick
//
//  Created by 김진우 on 2021/05/17.
//

import UIKit
import CoreLocation

class QRCheck: MainViewController{
    @IBOutlet weak var readerView: ReaderView!
    @IBOutlet weak var readButton: UIButton!
    var message = ""
    var titleM : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.readerView.delegate = self
        
        self.readButton.layer.masksToBounds = true
        self.readButton.layer.cornerRadius = 15
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !self.readerView.isRunning {
            self.readerView.stop(isButtonTap: false)
        }
    }
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        if self.readerView.isRunning {
            self.readerView.stop(isButtonTap: true)
        } else {
            self.readerView.start()
        }
        
        sender.isSelected = self.readerView.isRunning
    }
    @IBAction func Back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension QRCheck: ReaderViewDelegate {
    func alertMsgBox(strTitle : String, strMessage : String) {
        let alert = UIAlertController(title: strTitle,
                                      message: strMessage,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "확인",
                                      style: .default,
                                      handler: { action in
                                        switch action.style{
                                        case .default:
                                            self.appDelegate.GetUseHistory(type: "Now", num: nil){
                                                data,result in
                                                if let result = result{
                                                    if result.result_data != nil{
                                                        if result.result_data?.useHistory?.authTime == nil {
                                                            self.alertMsgBox(strTitle: "지문 인식", strMessage: "지문 인식이 필요합니다.\n지문인식을 완료한 경우 확인을 눌러주세요.")
                                                        }else{
                                                            self.Back(self)
                                                        }
                                                    }
                                                }
                                            }
                                        case .cancel:
                                            print("cancel")
                                        case .destructive:
                                            print("destructive")
                                        }
                                      }))
        alert.addAction(UIAlertAction(title: "취소",
                                      style: .cancel,
                                      handler: {action in
                                        switch action.style{
                                        case .cancel:
                                            let locationManager = CLLocationManager()
                                            locationManager.delegate = self
                                            var coor = locationManager.location?.coordinate
                                            var latitude = coor?.latitude ??  35.8471267472791
                                            var longitude = coor?.longitude ??  128.58281776895694
                                            self.appDelegate.KickboardUsestop(useNum: self.appDelegate.usernum, lon:longitude , lat:latitude){
                                                data in
                                                self.showToast(message: "사용을 취소 하였습니다.")
                                                self.Back(self)
                                            }
                                        case .default:
                                            print("default")
                                        case .destructive:
                                            print("destructive")
                                            
                                        }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func readerComplete(status: ReaderStatus) {
        
        var title = ""
        var message = ""
        switch status {
        case let .success(code):
            guard let code = code else {
                message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
                self.showToast(message: message)
                print("여기?")
                break
            }
            appDelegate.KickboardUsestart(kickboardNum: code ?? "-96"){
                (code,message) in
                if let code = code {
                    print("QRcode : ",code)
                    if code == 0 {
                        self.showToast(message: "킥보드 사용을 시작합니다.")
                        self.appDelegate.kickboarduse = 1
                        self.alertMsgBox(strTitle: "지문 인식", strMessage: "지문 인식이 필요합니다.\n지문인식을 완료한 경우 확인을 눌러주세요.")
                    }else if code == -96{
                        print(code)
                        print("안됐네")
                        self.showToast(message: message!)
                    }
                }
            }
        case .fail:
            message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
            print("인가?")
            showToast(message: message)
        case let .stop(isButtonTap):
            if isButtonTap {
                message = "바코드 읽기를 멈추었습니다."
                self.readButton.isSelected = readerView.isRunning
                showToast(message: message)
            } else {
                self.readButton.isSelected = readerView.isRunning
                showToast(message: message)
            }
            
        }
    }
}
