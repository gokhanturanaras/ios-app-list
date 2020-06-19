//
//  DeviceInfoViewController.swift
//  AppListSwift
//
//  Created by Gökhan on 10.07.2019.
//  
//

import UIKit
import ExternalAccessory
import CoreTelephony

class DeviceInfoViewController: UIViewController {

    static let networkInfo = CTTelephonyNetworkInfo()

    @IBOutlet weak var tableView: UITableView!
    var deviceInfoDatasource:AppDetailDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let connecteds = EAAccessoryManager.shared().connectedAccessories
        print("\(connecteds.count)")
        setupView()
        tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 12.0, *) {
            DeviceInfoViewController.networkInfo.serviceSubscriberCellularProvidersDidUpdateNotifier = { carrier in
                DispatchQueue.main.async {
                    print("User did change SIM")
                }
            }
        } else {
            // Fallback on earlier versions
        }
        deleteKeyChain()
        addKeyChain()
        searchKeyChain()
    }
    
    
    func setupView()  {
        deviceInfoDatasource = AppDetailDataSource(appData: DataCreate.deviceInfo())
        tableView.dataSource = deviceInfoDatasource
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func deleteKeyChain(){
        let itemKey = "My key"
        let keychainAccessGroupName = "JNC9G3AUW5.SiberKoruma"
        
        let queryDelete: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecAttrAccessGroup as String: keychainAccessGroupName as AnyObject
        ]
        
        let resultCodeDelete = SecItemDelete(queryDelete as CFDictionary)
        
        if resultCodeDelete != noErr {
            print("Error deleting from Keychain: \(resultCodeDelete)")
        }
    }
    
    func addKeyChain(){
        let itemKey = "My key"
        let itemValue = "My secretive bee 🐝"
        let keychainAccessGroupName = "JNC9G3AUW5.SiberKoruma"
        
        guard let valueData = itemValue.data(using: String.Encoding.utf8) else {
            print("Error saving text to Keychain")
            return
        }
        
        let queryAdd: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecValueData as String: valueData as AnyObject,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked,
            kSecAttrAccessGroup as String: keychainAccessGroupName as AnyObject
        ]
        
        let resultCode = SecItemAdd(queryAdd as CFDictionary, nil)
        
        if resultCode != noErr {
            print("Error saving to Keychain: \(resultCode)")
        }
    }
    
    func searchKeyChain(){
        let itemKey = "My key"
        let keychainAccessGroupName = "JNC9G3AUW5.SiberKoruma"
        
        let queryLoad: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecAttrAccessGroup as String: keychainAccessGroupName as AnyObject
        ]
        
        var result: AnyObject?
        
        let resultCodeLoad = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if resultCodeLoad == noErr {
            if let result = result as? Data,
                let keyValue = NSString(data: result,
                                        encoding: String.Encoding.utf8.rawValue) as String? {
                
                // Found successfully
                print(keyValue)
            }
        } else {
            print("Error loading from Keychain: \(resultCodeLoad)")
        }
    }

}
