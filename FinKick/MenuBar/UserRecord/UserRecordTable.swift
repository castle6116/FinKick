//
//  USerRecordTable.swift
//  FinKick
//
//  Created by 김진우 on 2021/04/14.
//

import UIKit

class UserRecordTable: UIViewController {
    @IBOutlet var tableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
}
extension UserRecordTable: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Memo.dummyMemoList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let vc = segue.destination as? DetailRecord
            if let first_index = sender as? Int {
                var target = Memo.dummyMemoList[first_index]
                appDelegate.GetUseHistory(type: "DT", num: target.num){
                    data, result in
                    if let result = result {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        guard let startTime = dateFormatter.date(from:(result.result_data?.useHistory!.startTime)!) else {return}
                        guard let endTime = dateFormatter.date(from: (result.result_data?.useHistory!.endTime) ?? "0000-00-00 00:00:00" ) else {return}
                        var useTime = Int(endTime.timeIntervalSince(startTime))
                        var useTimeMin = useTime / 60
                        var useTimeSec = useTime % 60
                            
                        let useTimeString = String(useTimeMin) + " 분 " + String(useTimeSec) + " 초"
                        
                        vc?.money = String(result.result_data?.useHistory?.price! ?? 0)
                        vc?.time = useTimeString
                        vc?.schema = result.result_data?.card?.scheme!
                        vc?.name = result.result_data?.card?.name!
                        var binCode = result.result_data?.card?.bin!
                        
                        if binCode?.count == 16 {
                            var binCode1 = binCode?.index(binCode!.startIndex,offsetBy: 0)
                            var binCode2 = binCode?.index(binCode!.startIndex,offsetBy: 4)
                                
                            var binCode3 = binCode?.index(binCode!.startIndex,offsetBy: 4)
                            var binCode4 = binCode?.index(binCode!.startIndex,offsetBy: 8)
                            
                            var binCode5 = binCode?.index(binCode!.startIndex,offsetBy: 8)
                            var binCode6 = binCode?.index(binCode!.startIndex,offsetBy: 12)
                            
                            var binCode7 = binCode?.index(binCode!.startIndex,offsetBy: 12)
                            var binCode8 = binCode?.index(binCode!.startIndex,offsetBy: 16)
                            vc?.bin = "\(binCode![binCode1!..<binCode2!]) \(binCode![binCode3!..<binCode4!]) \(binCode![binCode5!..<binCode6!]) \(binCode![binCode7!..<binCode8!])"
                            vc?.updateUI()
                        }else if binCode?.count == 15{
                            var binCode1 = binCode?.index(binCode!.startIndex,offsetBy: 0)
                            var binCode2 = binCode?.index(binCode!.startIndex,offsetBy: 4)
                                
                            var binCode3 = binCode?.index(binCode!.startIndex,offsetBy: 4)
                            var binCode4 = binCode?.index(binCode!.startIndex,offsetBy: 10)
                            
                            var binCode5 = binCode?.index(binCode!.startIndex,offsetBy: 10)
                            var binCode6 = binCode?.index(binCode!.startIndex,offsetBy: 15)
                            
                            vc?.bin = "\(binCode![binCode1!..<binCode2!]) \(binCode![binCode3!..<binCode4!]) \(binCode![binCode5!..<binCode6!])"
                            vc?.updateUI()
                        }
                    }
                }
                
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserRecordTableCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var target = Memo.dummyMemoList[indexPath.row]
        print("인덱스 패스 : ",indexPath.row)
        cell.useTime.text = target.time
        cell.usemoney.text = String(target.money) + " 원"
        cell.Date.text = dateFormatter.string(from: target.insertDate)

        // Configure the cell...
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
