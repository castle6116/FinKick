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
        var account : Account
        
    }
    struct Account : Codable{
        var email : String
        var id : String
    }
    var window: UIWindow?
    var success: Int = 0
    var ID : String?
    var Pass : String?
    var email : String = ""
    
    func getid(InputId:String ) {
        let url = "http://test.api.1997kfc.com/api/account/" + InputId
        success = 0
        AF.request(url,
                    method: .get,
                    parameters: nil,
                    encoding: URLEncoding.default,
                    headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
//                   여기서 가져온 데이터를 자유롭게 활용하세요.
                print(json)
                switch json.result{
                    case .success(let obj):
                        // 통신 성공 시
                        if obj is NSDictionary{
                            do{
                                //obj를 JSON으로 변경
                                let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                                // JSON Decoder 사용
                                let getInstanceData = try JSONDecoder().decode(Response.self, from: dataJSON)
                                print("code : ", getInstanceData.code)
                                print("message : ", getInstanceData.message)
                                print("email : ",getInstanceData.result_data.account.email)
                                print("id : ",getInstanceData.result_data.account.id)
                                self.success = 1
                            }catch{
                                print(error.localizedDescription)
                            }
                        }
                    case .failure(let e):
                        print(e.localizedDescription)
                        print("실패")
            }
        }
        print("하이")
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

