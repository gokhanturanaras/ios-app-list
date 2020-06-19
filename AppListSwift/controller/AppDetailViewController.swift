//
//  AppDetailViewController.swift
//  AppListSwift
//
//  Created by Gökhan on 5.07.2019.
//  
//

import UIKit

class AppDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var detailDataSource:AppDetailDataSource!
    var appDetails:Array<AppDetailModel>!
    var appData:LSPlugInKitProxy!
    var appListDataSource: AppListDataSource = AppListDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    
 
    func setupView()  {
        tableView.tableFooterView = UIView()
        detailDataSource = AppDetailDataSource(appData: DataCreate.appDetails(appData))
        tableView.dataSource = detailDataSource
        
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
