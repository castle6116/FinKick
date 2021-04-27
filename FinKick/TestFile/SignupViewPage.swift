//
//  SignupViewPage.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/21.
//

import UIKit

var SignupImage = [ "1.jpeg", "2.jpeg", "3.jpeg", "4.jpeg", "5.jpeg", "6.jpeg" ]

class SignupViewPage: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //페이지 컨트롤의 전체 페이지를 SignupImage 배열의 전체 개수 값으로 설정
        pageControl.numberOfPages = SignupImage.count
        // 페이지 컨트롤의 현재 페이지를 0으로 설정
        pageControl.currentPage = 0
        // 페이지 표시 색상을 밝은 회색 설정
        pageControl.pageIndicatorTintColor = UIColor.green
        // 현재 페이지 표시 색상을 검정색으로 설정
        pageControl.currentPageIndicatorTintColor = UIColor.black
        imgView.image = UIImage(named: SignupImage[0])
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        // SignupImage라는 배열에서 pageControl이 가르키는 현재 페이지에 해당하는 이미지를 imgView에 할당
        imgView.image = UIImage(named: SignupImage[pageControl.currentPage])
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
