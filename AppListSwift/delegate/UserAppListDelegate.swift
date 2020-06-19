//
//  UserAppListDelegate.swift
//  AppListSwift
//
//  Created by Gökhan on 5.07.2019.
//  
//

import Foundation
import UIKit

extension AppListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sgDetail", sender: indexPath.row)
    }
}
