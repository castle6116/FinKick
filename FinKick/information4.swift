//
//  information4.swift
//  FinKick
//
//  Created by 김진우 on 2021/03/12.
//

import UIKit

class information4: UIViewController {
    var image : UIImage?
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image = UIImage(named: "one.png")
        imgView.image = image
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
