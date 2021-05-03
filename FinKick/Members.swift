//
//  Members.swift
//  FinKick
//
//  Created by 김진우 on 2021/03/15.
//

import UIKit

class Members: UIViewController{
    @IBOutlet weak var IdInputField: UITextField!
    @IBOutlet var IdOverlapCheck: UIButton!
    @IBOutlet weak var PwInputField: UITextField!
    @IBOutlet var PwCheckInputField: UITextField!
    @IBOutlet var EmailInputField: UITextField!
    @IBOutlet weak var LoginError: UILabel!
    @IBOutlet var PasswordError: UILabel!
    @IBOutlet var PasswordErrorCheck: UILabel!
    @IBOutlet var EmailCheck: UILabel!
    @IBOutlet var MembershipButton: UIButton!
    @IBOutlet var EmailCertificationButton: UIButton!
    @IBOutlet var EmailCertificationInputField: UITextField!
    @IBOutlet var EmailCertification: UILabel!
    
    var loginID : String!
    var loginPW : String!
    var EmailCertificationCode : String = "0000"
    // 아이디 중복 체크 함수
    var IdCheckoverlap : Int = 0
    
    func IdOverlapCheckfunction(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(IdInputField.text != ""){
            appDelegate.getid(InputId: IdInputField.text!)
        }else{
            showToast(message: "아이디를 입력해 주세요")
        }
        
    }

    @objc func EmailCertification(_ sender: Any?) -> Bool{
        if EmailCertificationCode != EmailCertificationInputField.text {
            EmailCertification.text = "인증코드가 유효하지않습니다."
            EmailCertification.isHidden = false
            return false
        }else{
            EmailCertification.isHidden = true
            return true
        }
    }
    @objc func PassError(_ sender: Any?) -> Bool{
        if PwCheck(id: PwInputField.text) == false {
            PasswordError.text = "영어,숫자,특수문자 1개 이상 8~20자리"
            PasswordError.isHidden = false
        }else{
            PasswordError.isHidden = true
        }
        
        if PwInputField.text == PwCheckInputField.text {
            PasswordErrorCheck.isHidden = true
            return true
        }else{
            PasswordErrorCheck.text = "비밀번호와 동일하지 않습니다."
            PasswordErrorCheck.isHidden = false
            return false
        }
    }
    @objc func EmailError(_ sender: Any?) -> Bool{
        if EmailCheck(id: EmailInputField.text) == false {
            EmailCheck.text = "이메일 양식으로 작성해주세요."
            EmailCheck.isHidden = false
            return false
        }else{
            EmailCheck.isHidden = true
            return true
        }
    }
    @objc func IdError(_ sender: Any?) -> Bool{
        if IdCheckoverlap != 1 {
            LoginError.text = "중복 체크를 해주세요."
            LoginError.isHidden = false
            return false
        }else if IdCheck(id: IdInputField.text) == false {
            LoginError.text = "대소문자 및 숫자로 5~12 자리"
            LoginError.isHidden = false
            return false
        }else{
            LoginError.isHidden = true
            return true
        }
    }
    // 아이디 정규식
    func IdCheck(id: String?) -> Bool {
            guard id != nil else { return false }
            let idRegEx = "^[a-zA-Z]{1}[a-zA-Z0-9_]{4,11}$"
            let pred = NSPredicate(format:"SELF MATCHES %@", idRegEx)
            return pred.evaluate(with: id)
    }
    // 비밀번호 정규식
    func PwCheck(id: String?) -> Bool {
            guard id != nil else { return false }
            let idRegEx = "^(?=.*[0-9])(?=.*[a-z])(?=.*\\W)(?=\\S+$).{8,20}$"
            let pred = NSPredicate(format:"SELF MATCHES %@", idRegEx)
            return pred.evaluate(with: id)
    }
    //  이메일 정규식
    func EmailCheck(id: String?) -> Bool {
            guard id != nil else { return false }
            let idRegEx = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
            let pred = NSPredicate(format:"SELF MATCHES %@", idRegEx)
            return pred.evaluate(with: id)
    }
    
    @IBAction func OkButtonClick(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if PassError(self) == true && EmailError(self) == true && IdError(self) == true && EmailCertification(self) == true{
            CoreDataManager.shared.saveUser(id : IdInputField.text!, email : EmailInputField.text! , pw : PwInputField.text!){ onSuccess in
                print("saved = \(onSuccess)")
            }
            appDelegate.success = 1
            appDelegate.ID = IdInputField.text
           
            self.view.window?.rootViewController?.dismiss(animated: false, completion: {
                let homeVC = SecondViewController()
                  homeVC.modalPresentationStyle = .fullScreen
                 
                
                  appDelegate.window?.rootViewController?.present(homeVC, animated: true, completion: nil)
            })
            
        }
        else{
            appDelegate.success = 0
            showToast(message: "회원가입에 실패하셨습니다.")
        }
    }
    
    func showToast(message : String) {
            let width_variable:CGFloat = 10
            let toastLabel = UILabel(frame: CGRect(x: width_variable, y: self.view.frame.size.height-200, width: view.frame.size.width-2*width_variable, height: 80))
            // 뷰가 위치할 위치를 지정해준다. 여기서는 아래로부터 100만큼 떨어져있고, 너비는 양쪽에 10만큼 여백을 가지며, 높이는 35로
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(1)
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
    func KeyboardSetting()
        {
            //키보드가 올라올 때 리스너
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            //키보드가 내려갈 때 리스너
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }

        //키보드가 올라온 순간
        @objc func keyboardWillShow(_ sender: Notification) {
            //내가 선택한 UITextfield가 편집모드일 때
            if(EmailCertificationInputField.isEditing || EmailInputField.isEditing)
            {
                //키보드의 높이
                if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    let keyboardHeight = keyboardSize.height
                    print(keyboardHeight)
                    
                    //가상 키보드 높이만큼 화면의 y값을 감소
                    self.view.frame.origin.y = -keyboardHeight
                }
            }
        }
        
        //키보드가 내려온 순간
        @objc func keyboardWillHide(_ sender: Notification) {
            //화면 원상복귀
            self.view.frame.origin.y = 0
        }
    
    //프로그램이 시작 될 때 제일 처음 실행 되는 함수
    override func viewDidAppear(_ animated: Bool) {
        LoginError.isHidden = true
        PasswordError.isHidden = true
        PasswordErrorCheck.isHidden = true
        EmailCheck.isHidden = true
        EmailCertification.isHidden = true
        EmailInputField.keyboardType = .emailAddress
        IdInputField.keyboardType = .asciiCapable
        PwInputField.keyboardType = .asciiCapable
    }
    // 앱이 실행 되는 동안 계속 돌아가는 함수
    override func viewDidLoad() {
        KeyboardSetting()
        self.IdInputField.addTarget(self, action: #selector(self.IdError(_:)), for: .editingChanged)
        self.PwInputField.addTarget(self, action: #selector(self.PassError(_:)), for: .editingChanged)
        self.PwCheckInputField.addTarget(self, action: #selector(self.PassError(_:)), for: .editingChanged)
        self.EmailInputField.addTarget(self, action: #selector(self.EmailError(_:)), for: .editingChanged)
        self.EmailCertificationInputField.addTarget(self, action: #selector(self.EmailCertification(_:)), for: .editingChanged)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
