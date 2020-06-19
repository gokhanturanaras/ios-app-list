//
//  AppListViewController.swift
//  AppListSwift
//
//  Created by Gökhan on 4.07.2019.
//  
//

import UIKit

class AppListViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    var tableDataSource: UserAppListDataSource!
    var appInfo:AppInfo!
    var appListDataSource: AppListDataSource = AppListDataSource()
    var appList:Array<LSPlugInKitProxy>!
    var buildApps:Array<LSPlugInKitProxy>!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        // Do any additional setup after loading the view.
    }
    
    
    func viewSetup() {
        appList = appListDataSource.fetchApps() as? Array<LSPlugInKitProxy>
        var type = "User"
        if self.view.tag == 1 {
            navigationController?.navigationItem.title = "Sistem Uygulamaları"
            navigationItem.title =  "Sistem Uygulamaları"
            type = "System"
        } else {
             type = "User"
            navigationController?.navigationItem.title = "Kullanıcı Uygulamaları"
            navigationItem.title = "Kullanıcı Uygulamaları"
        }
        buildApps = appListDataSource.buildAppDictionary(appList, type: type) as? Array<LSPlugInKitProxy>
        tableDataSource = UserAppListDataSource(list:buildApps)
        tableView.tableFooterView = UIView()
        tableView.dataSource = tableDataSource
        tableView.delegate = self
        tableView.reloadData()
        
    }

 
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail" {
            let destination = segue.destination as? AppDetailViewController
            let data = buildApps?[sender as! Int]
            destination?.appData = data
        }
    }
    

}

