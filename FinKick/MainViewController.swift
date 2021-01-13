//
//  ViewController.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/01.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var IdInputField: UITextField!
    @IBOutlet weak var PwInputField: UITextField!
    @IBOutlet weak var LoginError: UILabel!
    @IBOutlet weak var SiginButton: UIButton!
    
    var loginID : String = "admin"
    var loginPW : String = "1234"
    
    // 사용자 에게 화면 팝업 후 확인 버튼 누르게 하기
    func showAlert(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // 로그인이 되는지 테스트 하는 함수
    @IBAction func LoginErrorFunc(_ sender : UIButton){
        if IdInputField.text == loginID {
            if PwInputField.text == loginPW{
                LoginError.text = "로그인 성공"
                LoginError.isHidden = false
            }else {
                LoginError.text = "비밀번호를 확인해 주세요"
                LoginError.isHidden = false
            }
        }else{
            LoginError.text = "아이디를 확인해 주세요"
            LoginError.isHidden = false
        }
    }
    
    //프로그램이 시작 될 때 제일 처음 실행 되는 함수
    override func viewDidAppear(_ animated: Bool) {
        LoginError.isHidden = true
    }
    // 앱이 실행 되는 동안 계속 돌아가는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

// 버튼 부분 보더 코너레디우스 설정
@IBDesignable extension UIView {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

