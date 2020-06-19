//
//  AppListTableViewCell.swift
//  AppListSwift
//
//  Created by Gökhan on 4.07.2019.
//  
//

import UIKit

class AppListTableViewCell: UITableViewCell {
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appBundleIdentifier: UILabel!
    @IBOutlet weak var appCompanyName: UILabel!
    @IBOutlet weak var appType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
