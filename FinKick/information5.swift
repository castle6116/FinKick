//
//  information5.swift
//  FinKick
//
//  Created by 김진우 on 2021/03/12.
//

import UIKit

class information5: UIViewController {
    var image : UIImage?
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var OKButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image = UIImage(named: "night.png")
        imgView.image = image
        // Do any additional setup after loading the view.
    }
    @IBAction func OkButtonClick(_ sender: Any) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "Members")
        vcName?.modalTransitionStyle = .coverVertical
        vcName?.modalPresentationStyle = .fullScreen
        //화면 전환 애니메이션을 설정합니다.
        self.present(vcName!, animated: true, completion: nil)
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
