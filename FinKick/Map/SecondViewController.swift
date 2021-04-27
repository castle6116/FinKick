//
//  ViewController.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/01.
//

import UIKit
import SideMenuSwift

class SecondViewController: UIViewController {
    
    
    @IBAction func ButtonAction(_ sender: Any) {
        
        SideMenuController.preferences.basic.menuWidth = 200
        SideMenuController.preferences.basic.statusBarBehavior = .none
        SideMenuController.preferences.basic.position = .above
        sideMenuController?.revealMenu()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

