//
//  QRCheck.swift
//  FinKick
//
//  Created by 김진우 on 2021/05/17.
//

import UIKit

class QRCheck: UIViewController {
    @IBOutlet weak var readerView: ReaderView!
    @IBOutlet weak var readButton: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
                title = "에러"
                message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
                break
            }
            appDelegate.KickboardUsestart(kickboardNum: code ?? "-99"){
                (code,message) in
                if let code = code {
                    print("QR성공")
                    if code == 0 {
                        print("사용 시작")
                    }else{
                        print(code)
                        print(message)
                    }
                    
                }
                
            }
            title = "통신에 성공 하였습니다. \n 사용 시작 합니다."
        case .fail:
            title = "에러"
            message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
        case let .stop(isButtonTap):
            if isButtonTap {
                title = "알림"
                message = "바코드 읽기를 멈추었습니다."
                self.readButton.isSelected = readerView.isRunning
            } else {
                self.readButton.isSelected = readerView.isRunning
                return
            }
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)

        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
