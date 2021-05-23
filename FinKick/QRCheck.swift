//
//  QRCheck.swift
//  FinKick
//
//  Created by 김진우 on 2021/05/17.
//

import UIKit

class QRCheck: MainViewController {
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
    func Back(_ sender: Any) {
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
            appDelegate.KickboardUsestart(kickboardNum: code ?? "-99"){
                (code,message) in
                if let code = code {
                    print("QRcode : ",code)
                    if code == 0 {
                        self.showToast(message: "킥보드 사용을 시작합니다.")
                        self.appDelegate.kickboarduse = 1
                        self.Back(self)
                    }else if code == -99{
                        print(code)
                        print("안됐네")
                        self.showToast(message: "킥보드를 이미 사용중 입니다.")
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
