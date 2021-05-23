//
//  AppDelegate.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/01.
//

import UIKit
import CoreData
import Alamofire
import KeychainSwift
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    struct Response : Codable {
        var code : Int?
        var message : String?
        var result_data : Result_data?
    }
    
    struct Result_data : Codable{
        var account : Account?
        var version : Version?
        var useHistory : useHistory?
        var card : cardUse?
        var token : String?
    }
    
    struct HistoryResponse : Codable {
        var code : Int?
        var message : String?
        var result_data : HistoryResult_data?
    }
    
    struct HistoryResult_data : Codable {
        var account : Account?
        var version : Version?
        var useHistory : [useHistory]?
        var token : String?
    }
    struct cardUse : Codable {
        var scheme : String?
        var name : String?
        var bin : String?
    }
    
    struct Version : Codable {
        var ios : String?
        var iosUrl : String?
    }
    
    struct useHistory : Codable {
        var num : Int?
        var startTime : String?
        var endTime : String?
        var price : Int?
    }
    struct Account : Codable{
        var id : String?
        var password : String?
        var phoneNumber : String?
        var registDay : String?
        var accountNum : Int?
        var type : String?
        var num : Int?
    }
    
    var window: UIWindow?
    var success: Int = 0
    var ID : String?
    var Pass : String?
    var email : String?
    var url : String!
    var cardWhether : Int = 0
    var width : Int?
    var height : Int?
    var kickboarduse : Int = 0
    var usernum : Int = 0
    
    static var loginToken : String?
    
    var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else {return nil}
        
        return version
    }
    
    func CardSetup(bin : String? , expirationMonth : String? , expirationYear : String? ,cvc : String? , password : String? , complation : ((Int?, String?) -> ())?){
        url = "http://test.api.finkick.xyz/api/card"
        let param : Parameters = ["bin" : bin , "expirationMonth" : expirationMonth, "expirationYear" : expirationYear, "cvc" : cvc , "password" : password]// JSON 객체로 변환할 딕셔너리 준비
        print(param)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        KeychainSwift().set(AppDelegate.loginToken!,forKey: "x-access-token")
        let headers : HTTPHeaders = ["x-access-token" : KeychainSwift().get("x-access-token")!]
        request.headers = headers
        
        do{
            try request.httpBody = JSONSerialization.data(withJSONObject: param, options: [])
        }catch{
            print("Http Body Error")
        }
        
        AF.request(request)
            .responseJSON{
                (response) in
            let statusCode = response.response!.statusCode
            switch response.result{
            case .success(let obj):
                print("POST 성공")
                if obj is NSDictionary{
                    do{
                        //obj를 JSON으로 변경
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        // JSON Decoder 사용
                        let getInstanceData = try JSONDecoder().decode(Response.self, from: dataJSON)
                        print(obj)
                        complation!(getInstanceData.code,getInstanceData.message)
                    }catch{
                        print(obj)
                        print("카드 저장 에러 발생 : ",error)
                    }
                }
            case.failure(let error):
                print("Error : ",error.localizedDescription)
            }
        }
    }
    
    func CardLookup(){
        url = "http://test.api.finkick.xyz/api/card"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        KeychainSwift().set(AppDelegate.loginToken!,forKey: "x-access-token")
        let headers : HTTPHeaders = ["x-access-token" : KeychainSwift().get("x-access-token")!]
        request.headers = headers
        
        AF.request(request)
            .responseJSON{
                (response) in
                let statusCode = response.response!.statusCode
                switch response.result{
                case .success(let obj):
                    print("GET 성공")
                    if obj is NSDictionary{
                        do{
                            //obj를 JSON으로 변경
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            // JSON Decoder 사용
                            let getInstanceData = try JSONDecoder().decode(Response.self, from: dataJSON)
                            print(getInstanceData)
                            print(getInstanceData.code)
                            if getInstanceData.code != nil{
                                self.cardWhether = 1
                            }else{
                                self.cardWhether = 0
                            }
                        }catch{
                            print(obj)
                            print("카드 조회 에러 발생 : ",error)
                        }
                    }
                case.failure(let error):
                    print("Error : ",error.localizedDescription)
                }
            }
    }
    
    func KickboardUsestop(useNum : Int, complation : ((Response?) -> ())?){
        print("유저 넘 : ",usernum)
        url = "http://test.api.finkick.xyz/api/usehistory/\(useNum)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        KeychainSwift().set(AppDelegate.loginToken!,forKey: "x-access-token")
        let headers : HTTPHeaders = ["x-access-token" : KeychainSwift().get("x-access-token")!]
        request.headers = headers
        
        AF.request(request)
            .responseJSON{
                (response) in
            let statusCode = response.response!.statusCode
            switch response.result{
            case .success(let obj):
                print("POST 성공")
                if obj is NSDictionary{
                    do{
                        //obj를 JSON으로 변경
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        // JSON Decoder 사용
                        let getInstanceData = try JSONDecoder().decode(Response.self, from: dataJSON)
                        complation!(getInstanceData)
                    }catch{
                        print(obj)
                        print("킥보드 사용 멈춤 에러 발생 : ",error)
                    }
                }
            case.failure(let error):
                print("Error : ",error.localizedDescription)
            }
        }
    }
    
    func KickboardUsestart(kickboardNum : String?, complation : ((Int?, String?) -> ())?){
        url = "http://test.api.finkick.xyz/api/usehistory"
        let param : Parameters = ["kickboardNum" : kickboardNum]// JSON 객체로 변환할 딕셔너리 준비
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        KeychainSwift().set(AppDelegate.loginToken!,forKey: "x-access-token")
        let headers : HTTPHeaders = ["x-access-token" : KeychainSwift().get("x-access-token")!]
        request.headers = headers
        do{
            try request.httpBody = JSONSerialization.data(withJSONObject: param, options: [])
        }catch{
            print("Http Body Error")
        }
        
        AF.request(request)
            .responseJSON{
                (response) in
            let statusCode = response.response!.statusCode
            switch response.result{
            case .success(let obj):
                print("POST 성공")
                if obj is NSDictionary{
                    do{
                        //obj를 JSON으로 변경
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        // JSON Decoder 사용
                        let getInstanceData = try JSONDecoder().decode(Response.self, from: dataJSON)
                        self.usernum = (getInstanceData.result_data?.useHistory?.num)!
                        complation!(getInstanceData.code,getInstanceData.message)
                    }catch{
                        print(obj)
                        print("킥보드 사용 시작 에러 발생 : ",error)
                    }
                }
            case.failure(let error):
                print("Error : ",error.localizedDescription)
            }
        }
    }
    
    func EmailAuthentication(value : String , email : String, complation : ((Int?, String?) -> ())?){
        url = "http://test.api.finkick.xyz/api/auth/email"
        let param : Parameters = ["type" : value , "email" : email]// JSON 객체로 변환할 딕셔너리 준비
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
        
        AF.request(request)
            .responseJSON{
                (response) in
            let statusCode = response.response!.statusCode
            switch response.result{
            case .success(let obj):
                print("POST 성공")
                if obj is NSDictionary{
                    do{
                        //obj를 JSON으로 변경
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        // JSON Decoder 사용
                        let getInstanceData = try JSONDecoder().decode(Response.self, from: dataJSON)
                        print(obj)
                        complation!(getInstanceData.code,getInstanceData.message)
                    }catch{
                        print(obj)
                        print("이메일 인증 에러 발생 : ",error)
                    }
                }
            case.failure(let error):
                print("Error : ",error.localizedDescription)
            }
        }
    }
    
    func GetUseHistory(type : String?, num : Int?,complation : ((HistoryResponse?, Response?) -> ())?){
        if type == "ALL"{
            url = "http://test.api.finkick.xyz/api/usehistory"
        }else if type == "DT"{
            url = "http://test.api.finkick.xyz/api/usehistory/\(num!)"
            print(url)
        }else if type == "Now"{
            url = "http://test.api.finkick.xyz/api/usehistory?isnowuse=true"
        }
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        KeychainSwift().set(AppDelegate.loginToken!,forKey: "x-access-token")
        let headers : HTTPHeaders = ["x-access-token" : KeychainSwift().get("x-access-token")!]
        request.headers = headers
        
        AF.request(request)
            .responseJSON{
                (response) in
                let statusCode = response.response!.statusCode
                switch response.result{
                case .success(let obj):
                    print("GET 성공")
                    if obj is NSDictionary{
                        do{
                            //obj를 JSON으로 변경
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            // JSON Decoder 사용
                            if type == "ALL" {
                                let getInstanceData = try JSONDecoder().decode(HistoryResponse.self, from: dataJSON)
                                print("유저 사용 기록 : ",getInstanceData)
                                complation!(getInstanceData, nil)
                            }else if type == "DT" || type == "Now"{
                                let getInstanceData = try JSONDecoder().decode(Response.self, from: dataJSON)
                                complation!(nil,getInstanceData)
                            }
                        }catch{
                            print("오브젝트는 : ",obj)
                            print("사용 기록 받아오기 에러 발생 : ",error)
                        }
                    }
                case.failure(let error):
                    print("Error : ",error.localizedDescription)
                }
            }
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
                let statusCode = json.response?.statusCode
                
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
                            print("서버 버전 : ",getInstanceData.result_data?.version?.ios)
                            
                            
                            if getInstanceData.result_data?.version?.ios != self.version {
                                
                                let alertController = UIAlertController(title: "버전이 낮습니다", message: "업데이트가 필요합니다.\n업데이트를  하지 않을 시 문제가 발생할 수 있습니다.", preferredStyle: UIAlertController.Style.alert)
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
                                print("버전 동일")
                            }
                        }catch(let error){
                            print(error)
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
        ID = id
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        do{
            try request.httpBody = JSONSerialization.data(withJSONObject: param, options: [])
        }catch{
            print("Http Body Error")
        }
        
        AF.request(request)
            .responseJSON{
                (response) in
                let statusCode = response.response!.statusCode
                switch response.result{
                case .success(let obj):
                    print("POST 성공")
                    if obj is NSDictionary{
                        do{
                            //obj를 JSON으로 변경
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            // JSON Decoder 사용
                            let getInstanceData = try JSONDecoder().decode(Response.self, from: dataJSON)
                            AppDelegate.loginToken = getInstanceData.result_data?.token
                            print("로그인 하는 계정 : ",obj)
                            complation!(statusCode)
                        }catch{
                            print(error)
                            complation!(statusCode)
                        }
                    }
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

        AF.request(request)
            .responseJSON{
                (response) in
                let statusCode = response.response!.statusCode
                switch response.result{
                case .success(let obj):
                    print("POST 성공")
                    if obj is NSDictionary{
                        do{
                            //obj를 JSON으로 변경
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            // JSON Decoder 사용
                            let getInstanceData = try JSONDecoder().decode(Response.self, from: dataJSON)
                            complation!(getInstanceData,statusCode)
                        }catch{
                            print(error)
                            complation!(nil,statusCode)
                        }
                    }
                case.failure(let error):
                    print("Error")
                    complation!(nil ,statusCode)
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
                            
                            print("아이디 중복 체크 : ",getInstanceData)
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

