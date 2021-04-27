//
//  SideMenuContentView.swift
//  FinKick
//
//  Created by 김진우 on 2021/03/30.
//

import UIKit

class SideMenuContentView: UIViewController{
    @IBOutlet weak var user_image : UIImageView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 50
        // Do any additional setup after loading the view.
        user_image.layer.cornerRadius = user_image.frame.height/2
        user_image.layer.borderWidth = 1
        user_image.clipsToBounds = true
        user_image.layer.borderColor = UIColor.clear.cgColor  //원형 이미지의 테두리 제거
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
