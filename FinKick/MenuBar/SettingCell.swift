//
//  SettingCell.swift
//  FinKick
//
//  Created by 김진우 on 2021/05/24.
//

import UIKit

class SettingCell: UITableViewCell {
    @IBOutlet var information: UILabel!
    @IBOutlet var policies: UILabel!
    @IBOutlet var version: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
