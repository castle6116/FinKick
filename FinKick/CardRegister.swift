//
//  CardRegister.swift
//  FinKick
//
//  Created by 김진우 on 2021/05/18.
//

import UIKit

class CardRegister: UIViewController , UITextFieldDelegate{
    @IBOutlet var CardTextField: UITextField!
    @IBOutlet var CardPassWord: UITextField!
    @IBOutlet var CardMonth: UITextField!
    @IBOutlet var CardYear: UITextField!
    @IBOutlet var CardCVC: UITextField!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func Cardregist() {
        appDelegate.CardSetup(bin: CardTextField.text, expirationMonth: CardMonth.text, expirationYear: CardYear.text, cvc: CardCVC.text, password: CardPassWord.text){
            (code , message) in
            if let code = code {
                MainViewController().showToast(message: "\(code) : \(message)")
                print(code," : ",message)
                if code == 0 {
                    self.Back(self)
                    self.appDelegate.cardWhether = 2
                }
            }
        }
    }
    func Back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    @IBAction func CardMonthField(_ sender: Any) {
        checkMaxLength(textField: CardMonth, maxLength: 2)
    }
    @IBAction func CardYearField(_ sender: Any) {
        checkMaxLength(textField: CardYear, maxLength: 2)
    }
    @IBAction func CardCvcField(_ sender: Any) {
        checkMaxLength(textField: CardCVC, maxLength: 3)
    }
    
    @IBAction func CardPwField(_ sender: Any) {
        checkMaxLength(textField: CardPassWord, maxLength: 2)
    }
    
    @IBAction func CardBinField(_ sender: Any) {
        checkMaxLength(textField: CardTextField, maxLength: 16)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CardTextField.delegate = self
        CardPassWord.delegate = self
        CardMonth.delegate = self
        CardYear.delegate = self
        CardCVC.delegate = self
        
        
        // Do any additional setup after loading the view.
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
