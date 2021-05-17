//
//  MembershipImageView.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/19.
//

import UIKit

class MapPager: UIPageViewController, UIPageViewControllerDelegate {
    
    var pendingPage: Int?
    let identifiers: NSArray = ["MapView"]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var VCArray: [UIViewController] = {
        return [self.VCInstance(name: "MapView")]
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
extension UIView{
    public var viewHeight : CGFloat{
        return self.frame.size.height
    }
    public var viewWidth : CGFloat{
        return self.frame.size.width
    }
    
}
