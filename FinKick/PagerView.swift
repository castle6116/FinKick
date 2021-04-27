//
//  MembershipImageView.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/19.
//

import UIKit

class PagerView: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pendingPage: Int?
    
    let identifiers: NSArray = ["information1", "information2", "information3","information4","information5"]

    lazy var VCArray: [UIViewController] = {
        return [self.VCInstance(name: "information1"),
                self.VCInstance(name: "information2"),
                self.VCInstance(name: "information3"),
                self.VCInstance(name: "information4"),
                self.VCInstance(name: "information5")]
    }()

    required init?(coder aDecoder: NSCoder) {
             super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self

        if let firstVC = VCArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

            guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else { return nil }
            
            let previousIndex = viewControllerIndex - 1
                    //print(previousIndex)

            if previousIndex < 0 {
                return nil
            }else {
                return VCArray[previousIndex]
            }
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else { return nil }
            let nextIndex = viewControllerIndex + 1

            if nextIndex >= VCArray.count {
                return nil
            } else {
                return VCArray[nextIndex]
            }
        }
}
