//
//  AppDetailTableViewCell.swift
//  AppListSwift
//
//  Created by Gökhan on 5.07.2019.
//  
//

import UIKit

class AppDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appDetail: UILabel!
    @IBOutlet weak var appHeader: UILabel!
    @IBOutlet weak var appContentTxt: UILabel!
    @IBOutlet weak var swAppStatus: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateRow(appTitle:String, appDetail:String)  {
        self.appTitle.text = appTitle
        self.appDetail.text = appDetail
    }
    
    func updateHeader(appHeader:String)  {
        self.appHeader.text = appHeader
    }
    
    func updateContent(appContentTxt:String,status:Bool)  {
        self.appContentTxt.text = appContentTxt
        self.swAppStatus.isOn = status

    }
}
