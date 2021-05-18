//
//  DetailRecord.swift
//  FinKick
//
//  Created by 김진우 on 2021/04/13.
//

import UIKit

class DetailRecord: UIViewController {
    @IBOutlet var Credit: UILabel!
    @IBOutlet var ConnectTime: UILabel!
    @IBOutlet var CardName: UILabel!
    @IBOutlet var CardSchema: UILabel!
    @IBOutlet var CardBin: UILabel!
    
    @IBOutlet var UseMoney: UILabel!
    @IBOutlet var UseMoney2: UILabel!
    var money : String?
    var time : String?
    var schema : String?
    var name : String?
    var bin : String?
    
    func updateUI() {
        if let money = money {
            Credit.text = money+" 원"
            UseMoney.text = money+" 원"
            UseMoney2.text = money+" 원"
            ConnectTime.text = time
            CardSchema.text = schema
            CardName.text = name
            CardBin.text = bin
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
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
