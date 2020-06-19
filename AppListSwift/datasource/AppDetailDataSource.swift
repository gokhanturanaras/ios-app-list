//
//  AppDetailDataSource.swift
//  AppListSwift
//
//  Created by Gökhan on 5.07.2019.
//  
//

import UIKit

class AppDetailDataSource: NSObject,UITableViewDataSource {
    let appData:Array<AppDetailModel>!
    init(appData:Array<AppDetailModel>) {
        self.appData = appData
        super.init()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData == nil ? 0 : appData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = appData[indexPath.row]
        if model.type == ContentType.CONTENT {
            let cell = tableView.dequeueReusableCell(withIdentifier: "appDetail", for: indexPath) as! AppDetailTableViewCell
            cell.updateRow(appTitle: appData[indexPath.row].appTitle, appDetail: appData[indexPath.row].appDetail)
            
            return cell
        }else if model.type == ContentType.HEADER {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! AppDetailTableViewCell
            cell.updateHeader(appHeader: appData[indexPath.row].appHeader)
            
            return cell
        }else if model.type == ContentType.HEADER_CONTENT {
            let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as! AppDetailTableViewCell
            cell.updateContent(appContentTxt: appData[indexPath.row].appHeader, status: appData[indexPath.row].status)
            
            return cell
        }
        
        
        return UITableViewCell()
    
    }
    

}
