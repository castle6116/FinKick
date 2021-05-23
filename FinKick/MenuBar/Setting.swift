//
//  Setting.swift
//  FinKick
//
//  Created by 김진우 on 2021/04/05.
//

import UIKit

class Setting: UIViewController {
    @IBOutlet var Information: UITableView!
    @IBOutlet var TermsAndpolicies: UITableView!
    @IBOutlet var appVersion: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func Back(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        Information.delegate = self
        Information.dataSource = self
        TermsAndpolicies.delegate = self
        TermsAndpolicies.dataSource = self
        appVersion.delegate = self
        appVersion.dataSource = self
        // Do any additional setup after loading the view.
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
extension Setting : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == TermsAndpolicies{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "informationCell", for: indexPath) as! SettingCell
        if tableView == Information {
            let cell = tableView.dequeueReusableCell(withIdentifier: "informationCell", for: indexPath) as! SettingCell
            cell.information.text = appDelegate.ID
        }else if tableView == TermsAndpolicies{
            let cell = tableView.dequeueReusableCell(withIdentifier: "policies", for: indexPath) as! SettingCell
            if indexPath.row == 1 {
                cell.policies.text = "이용 약관"
            }
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "version", for: indexPath) as! SettingCell
        }
        
        
        return cell
    }
    
}
