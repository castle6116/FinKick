//
//  UserTable.swift
//  FinKick
//
//  Created by 김진우 on 2021/04/13.
//

import UIKit

class UserTable : UIPageViewController, UIPageViewControllerDelegate {
    
    var pendingPage: Int?
    let identifiers: NSArray = ["UserTable"]

    lazy var VCArray: [UIViewController] = {
        return [self.VCInstance(name: "UserTable")]
    }()

    required init?(coder aDecoder: NSCoder) {
             super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self

        if let firstVC = VCArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }

}
