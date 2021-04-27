//
//  ViewController.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/01.
//

import UIKit

class MembershipView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Back(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
