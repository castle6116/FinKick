//
//  CardRegister.swift
//  FinKick
//
//  Created by 김진우 on 2021/05/18.
//

import UIKit

class CardRegister: UIViewController {
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
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
