//
//  UserAppListDataSource.swift
//  AppListSwift
//
//  Created by Gökhan on 4.07.2019.
//  
//

import Foundation

class UserAppListDataSource :NSObject, UITableViewDataSource{
  
    var appList:Array<LSPlugInKitProxy>!
    
    init(list:Array<LSPlugInKitProxy>) {
        appList = list
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appList == nil ? 0 : appList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAppList", for: indexPath) as! AppListTableViewCell
        if appList[indexPath.row].containingBundle != nil {
            cell.appName.text = "\( appList[indexPath.row].containingBundle.itemName ?? appList[indexPath.row].containingBundle.localizedName ?? "-")"
        }
        cell.appBundleIdentifier.text =  appList[indexPath.row].containingBundle.applicationIdentifier// appList[indexPath.row].originalIdentifier //appList[indexPath.row].containingBundle.applicationIdentifier //appList[indexPath.row].originalIdentifier
        if appList[indexPath.row].containingBundle != nil{
            cell.appCompanyName.text = appList[indexPath.row].containingBundle.vendorName
            cell.appType.text = appList[indexPath.row].containingBundle.genre
        }
       
       
        return cell
    }
  
    
}
