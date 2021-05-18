//
//  UserRecord.swift
//  FinKick
//
//  Created by 김진우 on 2021/04/05.
//

import UIKit

class UserRecord: UIViewController {

    @IBAction func Back(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
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
class Memo{
    var content : String
    var insertDate : Date
    var time : String
    var money : Int
    var num : Int
    
    init(content : String, time : String, money : Int, insertDate : Date, num : Int) {
        self.content = content
        self.time = time
        self.money = money
        self.insertDate = insertDate
        self.num = num
    }
    
    static var dummyMemoList = [Memo]()
}
