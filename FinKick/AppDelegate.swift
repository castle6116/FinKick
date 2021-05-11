//
//  AppDelegate.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/01.
//

import UIKit
import CoreData
import Alamofire

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    struct Response : Codable {
        var code : Int
        var message : String
        var result_data : Result_data
    }
    
    struct Result_data : Codable{
        var account : Account?
        var version : Version?
    }
    
    struct Version : Codable {
        var ios : String?
        var iosUrl : String?
    }
    
    struct Account : Codable{
        var id : String?
        var password : String?
        var phoneNumber : String?
    }
    
    var window: UIWindow?
    var success: Int = 0
    var ID : String?
    var Pass : String?
    var email : String?
    var url : String!
    
    var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String else {return nil}
        
        return version
    }
    
    func Getversion(){
        url = "http://test.api.finkick.xyz/api/version"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            //            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
                //                   여기서 가져온 데이터를 자유롭게 활용하세요
                let statusCode = json.response!.statusCode
                
                switch json.result{
                case .success(let obj):
                    // 통신 성공 시
                    if obj is NSDictionary{
                        do{
                            //obj를 JSON으로 변경
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            // JSON Decoder 사용
                            let getInstanceData = try JSONDecoder().decode(Response.self, from: dataJSON)
                            
                            print("어플 버전 : ",self.version!)
                            print("서버 버전 : ",getInstanceData.result_data.version?.ios)
                            if getInstanceData.result_data.version?.ios == self.version {

                                let alertController = UIAlertController(title: "버전이 낮습니다", message: "업데이트가 필요합니다.\n업데이트를 하지 않을 시 문제가 발생할 수 있습니다.", preferredStyle: UIAlertController.Style.alert)
                                alertController.addAction(UIAlertAction.init(title: "확인", style: UIAlertAction.Style.default, handler: { (action) in
                                    // 버튼 눌렸을 때 활동 할 것 추가 하기
                                  //  UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                                }))
                                var topController = UIApplication.shared.keyWindow?.rootViewController
                                if topController != nil {
                                    while let presentedViewController = topController?.presentedViewController {
                                        topController = presentedViewController
                                    }
                                }
                                topController!.present(alertController, animated: false, completion: {

                                })
                            }else{
                                print("못드갔다")
                            }
                        }catch(let error){
                            print("getversion Error : ",error.localizedDescription)
                        }
                    }
                case .failure(let e):
                    print(e.localizedDescription)
                    print("실패")
                }
            }
    }
    
    func loginFunc(id : String, password : String, complation : ((Int?) -> ())?){
        url = "http://test.api.finkick.xyz/api/auth/login"
        let param : Parameters = ["id" : id , "password" : password]// JSON 객체로 변환할 딕셔너리 준비
        print(param)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        do{
            try request.httpBody = JSONSerialization.data(withJSONObject: param, options: [])
        }catch{
            print("Http Body Error")
        }
        
        AF.request(request).responseString{(response) in
            let statusCode = response.response!.statusCode
            switch response.result{
            case .success:
                print("POST 성공")
                complation!(statusCode)
            case.failure(let error):
                print("Error")
                complation!(statusCode)
            }
        }
    }
    func Putmember(id : String , password : String, phoneNumber : String, complation : ((Response?, Int?) -> ())?)  {
        url = "http://test.api.finkick.xyz/api/account"
        let param : Parameters = ["id" : id , "password" : password , "phoneNumber" : phoneNumber]// JSON 객체로 변환할 딕셔너리 준비
        print(param)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        do{
            try request.httpBody = JSONSerialization.data(withJSONObject: param, options: [])
        }catch{
            print("Http Body Error")
        }
        
        AF.request(request).responseString{(response) in
            let statusCode = response.response!.statusCode
            switch response.result{
            case .success:
                print("POST 성공")
                complation!(nil,statusCode)
            case.failure(let error):
                print("Error")
                complation!(nil,statusCode)
            }
        }
    }
    
    func Getid(InputId:String, complation : ((Response?, Int?) -> ())? ) {
        url = "http://test.api.finkick.xyz/api/account/" + InputId
        success = 0
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            //            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
                //                   여기서 가져온 데이터를 자유롭게 활용하세요
                let statusCode = json.response!.statusCode
                
                switch json.result{
                case .success(let obj):
                    // 통신 성공 시
                    if obj is NSDictionary{
                        do{
                            //obj를 JSON으로 변경
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            // JSON Decoder 사용
                            let getInstanceData = try JSONDecoder().decode(Response.self, from: dataJSON)
                            
                            complation!(getInstanceData, statusCode)
                        }catch{
                            complation!(nil, statusCode)
                        }
                    }
                case .failure(let e):
                    print(e.localizedDescription)
                    print("실패")
                }
            }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Users") // 여기는 파일명을 적어줘요.
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Getversion()
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.27, green: 0.29, blue: 0.35, alpha: 1.00)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

