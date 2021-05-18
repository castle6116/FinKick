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
    
    func showToast(message : String) {
            let width_variable:CGFloat = 10
            let toastLabel = UILabel(frame: CGRect(x: width_variable, y: self.view.frame.size.height-200, width: view.frame.size.width-2*width_variable, height: 80))
            // 뷰가 위치할 위치를 지정해준다. 여기서는 아래로부터 100만큼 떨어져있고, 너비는 양쪽에 10만큼 여백을 가지며, 높이는 35로
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont(name: "NanumSquareBold", size: 18.0)
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
    }
    func pushMessage(message : String? , title : String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)

        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
                self.pushMessage(message: message, title: title)
                print("여기?")
                break
            }
            appDelegate.KickboardUsestart(kickboardNum: code ?? "-99"){
                (code,message) in
                if let code = code {
                    print("QR성공")
                    if code == 0 {
                        print("됐냐")
                        self.pushMessage(message: "\(code) 번 킥보드 사용을 시작합니다.", title: "사용 시작")
                    }else{
                        print(code)
                        print("안됐네")
                        self.pushMessage(message: message!, title: "실패")
                    }
                    
                }
                
            }
        case .fail:
            title = "에러"
            message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
            print("인가?")
            pushMessage(message: message, title: title)
        case let .stop(isButtonTap):
            if isButtonTap {
                title = "알림"
                message = "바코드 읽기를 멈추었습니다."
                print("여")
                self.readButton.isSelected = readerView.isRunning
            } else {
                print("기")
                self.readButton.isSelected = readerView.isRunning
            }
            pushMessage(message: message, title: title)
        }
    }
}
