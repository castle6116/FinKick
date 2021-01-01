//
//  ViewController.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/01.
//

import UIKit

class ImageController: UIViewController {
    @IBOutlet weak var lbHello: UILabel!
    
    @IBOutlet weak var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSend(_ sender: UIButton) {
        lbHello.text = "Hello, " + txtName.text!
    }
    
}

