//
//  ViewController.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/01.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    @IBOutlet weak var IdInputField: UITextField!
    @IBOutlet weak var PwInputField: UITextField!
    @IBOutlet weak var LoginError: UILabel!
    
    var loginID : String = ""
    var loginPW : String = ""
    var membershipOK : Int?
    
    @IBAction func moveLogin() {
        appDelegate.ID = loginID
        appDelegate.Pass = loginPW
        //storyboard를 통해 두번쨰 화면의 storyboard ID를 참조하여 뷰 컨트롤러를 가져옵니다.
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SideMenu") else{
            return
        }
        // 전체 화면으로 불러옴
        uvc.modalPresentationStyle = .fullScreen
        //화면 전환 애니메이션을 설정합니다.
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출합니다.
        self.present(uvc, animated: true)
    }
    
    @IBAction func moveMembership() {
        //storyboard를 통해 두번쨰 화면의 storyboard ID를 참조하여 뷰 컨트롤러를 가져옵니다.
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "Membership") else{
            return
        }
        // 전체 화면으로 불러옴
        uvc.modalPresentationStyle = .fullScreen
        //화면 전환 애니메이션을 설정합니다.
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출합니다.
        self.present(uvc, animated: true)
   
    }


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
        // 특정 시간 후 실행
        let time = DispatchTime.now() + .seconds(5)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.LoginError.isHidden = true
        }
        
        if IdInputField.text == loginID {
            if PwInputField.text == loginPW{
                LoginError.text = "로그인 성공"
                LoginError.isHidden = false
                moveLogin()
            }else {
                LoginError.text = "비밀번호를 확인해 주세요"
                LoginError.isHidden = false
            }
        }else{
            LoginError.text = "아이디를 확인해 주세요"
            LoginError.isHidden = false
        }
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
    //저장된 데이터 보기
    fileprivate func getAllUsers() {
            let users: [Users] = CoreDataManager.shared.getUsers()
            let userID: [String?] = users.map({$0.id})
            let userPW: String = users.filter({$0.id == appDelegate.ID}).first!.pw!
            print("User ID = \(userID)")
            print("User PW = \(userPW)")
    }
    //데이터 삭제
    fileprivate func deleteUser(_ id: String) {
            CoreDataManager.shared.deleteUser(id: id) { onSuccess in
                print("deleted = \(onSuccess)")
            }
        }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //프로그램이 시작 될 때 제일 처음 실행 되는 함수
    override func viewDidAppear(_ animated: Bool) {
        membershipOK = appDelegate.success
        if(membershipOK == 1){
            showToast(message: "회원가입에 성공하였습니다.")
            let users: [Users] = CoreDataManager.shared.getUsers()
            IdInputField.text = appDelegate.ID
            PwInputField.text = users.filter({$0.id == appDelegate.ID}).first!.pw!
            getAllUsers()
        }
        LoginError.isHidden = true
        IdInputField.keyboardType = .asciiCapable
        PwInputField.keyboardType = .asciiCapable
        var locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    // 앱이 실행 했을 때
    override func viewDidLoad() {
        super.viewDidLoad()
        //키보드 활성화시 화면 올라감
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

