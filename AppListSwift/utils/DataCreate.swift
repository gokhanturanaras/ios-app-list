//
//  DataCreate.swift
//  AppListSwift
//
//  Created by Gökhan on 10.07.2019.
//  
//

import Foundation
import UIKit
import AdSupport
import CoreBluetooth
import CoreTelephony


public class DataCreate {
    static let networkInfo = CTTelephonyNetworkInfo()

   static func appDetails(_ appData:LSPlugInKitProxy) -> Array<AppDetailModel> {
        var bluetoothIzni:Bool = false
        var herZamanVeUygulamaYiKullanirkenKonum:Bool = false
        var herZamanKonum:Bool = false
        var galeriYeErisim:Bool  = false
        var kameraIzni:Bool  = false
        var mikrofonIzni:Bool  = false
        var animsaticiIzni:Bool  = false
        var takvimIzni:Bool  = false
        var hareketSensorIzni:Bool  = false
        var uygulamyiKullanirkenLokasyon:Bool  = false
        var appleMusicErisim:Bool  = false
        var galeriyeResimEkleme:Bool  = false
        var faceIdKullanimi:Bool  = false
        var rehbereErisim:Bool  = false
        var sesliOkuma:Bool  = false
        var arkaPlanUygulamalari:Array<String>!
        var platformDestekleri:Array<String>!
        var fonts:Array<String>!
        var devices:Array<String>!
        var deviceFamilys:Array<Int>!
        var orientations:Array<String>!
        var domains:Dictionary<String,Any>!
        var transportSecurity:Dictionary<String,Any>!
        var shortcutItems:Array<Any>!
        var tvUygulamasimi:Bool  = false
        
        var region:String!
        
        var arkaPlanVoip:Bool = false
        var arkaPlanSes:Bool = false
        var arkaPlanLokasyon:Bool = false
        var arkaPlanBildirim:Bool = false
        var arkaPlanBleutooth:Bool = false
        var arkaPlanFetch:Bool = false
        let turId = appData.containingBundle?.genreID ?? 0
        var allowsArbitaryLoads:Bool = false
        var localArbitaryLoads:Bool = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        //   let isInstall = appListDataSource.isInstalled(appData.containingBundle.applicationIdentifier)
        var  appDetails = Array<AppDetailModel>()
        appDetails.append(AppDetailModel.init(appHeader: "Uygulama Bilgisi", type: ContentType.HEADER))
        appDetails.append(AppDetailModel.init(appTitle: "Uygulama Adı", appDetail: appData.containingBundle.itemName ?? appData.containingBundle.localizedName ?? "-",type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Uygulama Versiyonu", appDetail: appData.containingBundle.shortVersionString,type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Bundle Identifier", appDetail: appData.containingBundle.bundleIdentifier,type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Uygulama Tür ID", appDetail:"\(appData.containingBundle?.genreID ?? 0)",type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Receipt Url", appDetail:"\(appData.containingBundle?.appStoreReceiptURL.absoluteString ?? "-")",type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Bundle Url", appDetail:"\(appData.containingBundle?.bundleURL.absoluteString ?? "-")",type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Container Url", appDetail:"\(appData.containingBundle?.containerURL.absoluteString ?? "-")",type: ContentType.CONTENT))
        if appData.containingBundle.genre != nil {
            appDetails.append(AppDetailModel.init(appTitle: "Uygulama Tür Adı", appDetail: appData.containingBundle.genre,type: ContentType.CONTENT))
        }
        appDetails.append(AppDetailModel.init(appTitle: "Uygulama Store  ID'si", appDetail: "\(appData.containingBundle.itemID ?? 0)",type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Kayıt Tarihi", appDetail: dateFormatter.string(from: appData.containingBundle.registeredDate),type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Minumum Sistem Versiyon", appDetail: appData.containingBundle.minimumSystemVersion,type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Disk Kullanım Kapasitesi", appDetail: "\(appData.containingBundle.diskUsage.staticUsage ?? 0)",type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Team Id", appDetail: "\(appData.containingBundle.teamID ?? "-")",type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Değerlendirme Sırası", appDetail: "\(appData.containingBundle.ratingRank ?? 0)",type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Değerlendirme Etiketi", appDetail: "\(appData.containingBundle.ratingLabel ?? "-")",type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appTitle: "Watch Kit Version", appDetail: "\(appData.containingBundle.watchKitVersion ?? "-")",type: ContentType.CONTENT))
        appDetails.append(AppDetailModel.init(appHeader: "Watch Kit Uygulamasımı", status: appData.containingBundle.isWatchKitApp , type: ContentType.HEADER_CONTENT))
        
        
        appDetails.append(AppDetailModel.init(appHeader: "Store Uygulması mı?", status: turId != 0, type: ContentType.HEADER_CONTENT))
        
        
        if appData.containingBundle._infoDictionary != nil {
            
            for (key,value) in appData.containingBundle._infoDictionary.propertyList{
                if  key as! String == "NSBluetoothPeripheralUsageDescription" {
                    bluetoothIzni = true
                }else if  key as! String == "NSLocationAlwaysAndWhenInUseUsageDescription" {
                    herZamanVeUygulamaYiKullanirkenKonum = true
                }else if  key as! String == "NSLocationAlwaysUsageDescription" {
                    herZamanKonum = true
                }else if  key as! String == "NSPhotoLibraryUsageDescription" {
                    galeriYeErisim = true
                }else if  key as! String == "NSCameraUsageDescription" {
                    kameraIzni = true
                }else if  key as! String == "NSMicrophoneUsageDescription" {
                    mikrofonIzni = true
                }else if  key as! String == "NSRemindersUsageDescription" {
                    animsaticiIzni = true
                }else if  key as! String == "NSCalendarsUsageDescription" {
                    takvimIzni = true
                }else if  key as! String == "NSMotionUsageDescription" {
                    hareketSensorIzni = true
                }else if  key as! String == "NSLocationWhenInUseUsageDescription" {
                    uygulamyiKullanirkenLokasyon = true
                }else if  key as! String == "NSAppleMusicUsageDescription" {
                    appleMusicErisim = true
                }else if  key as! String == "NSPhotoLibraryAddUsageDescription" {
                    galeriyeResimEkleme = true
                }else if  key as! String == "NSFaceIDUsageDescription" {
                    faceIdKullanimi = true
                }else if  key as! String == "NSContactsUsageDescription" {
                    rehbereErisim = true
                }else if  key as! String == "NSSpeechRecognitionUsageDescription" {
                    sesliOkuma = true
                }else if  key as! String == "UISupportsTVApp" {
                    tvUygulamasimi = value as? Bool ?? false
                }else if key as! String == "UIBackgroundModes"{
                    arkaPlanUygulamalari = value as? Array<String>
                    if arkaPlanUygulamalari != nil {
                        for item in arkaPlanUygulamalari{
                            if item == "audio"{
                                arkaPlanSes = true
                            }else if item == "location"{
                                arkaPlanLokasyon = true
                            }else if item == "remote-notification"{
                                arkaPlanBildirim = true
                            }else if item == "fetch"{
                                arkaPlanFetch = true
                            }else if item == "bluetooth-central"{
                                arkaPlanBleutooth = true
                            }else if item == "voip"{
                                arkaPlanVoip = true
                            }
                        }
                    }
                }else if key as! String == "UIAppFonts"{
                    fonts = value as? Array<String>
                }else if key as! String == "UISupportedDevices"{
                    devices = value as? Array<String>
                }else if key as! String == "UIDeviceFamily"{
                    deviceFamilys = value as? Array<Int>
                }else if key as! String == "CFBundleDevelopmentRegion"{
                    region = value as? String
                }else if key as! String == "UISupportedInterfaceOrientations"{
                    orientations = value as? Array<String>
                }else if key as! String == "UIApplicationShortcutItems"{
                    shortcutItems = value as? Array<Any>
                }else if key as! String == "CFBundleSupportedPlatforms"{
                    platformDestekleri = value as? Array<String>
                }else if key as! String == "NSAppTransportSecurity"{
                    transportSecurity = value as? Dictionary
                    allowsArbitaryLoads = transportSecurity["NSAllowsArbitraryLoads"] as? Bool ?? false
                    localArbitaryLoads = transportSecurity["NSAllowsLocalNetworking"] as? Bool ?? false
                    domains = transportSecurity["NSExceptionDomains"] as? Dictionary<String,Any>
                    
                }
            }
            
        }
        appDetails.append(AppDetailModel.init(appTitle: "Geliştirme Bölgesi", appDetail: region,type: ContentType.CONTENT))
        
        //İzinlerin gösterilmesi.
        appDetails.append(AppDetailModel.init(appHeader: "Uygulama İzinleri", type: ContentType.HEADER))
        
        appDetails.append(AppDetailModel.init(appHeader: "Bluetooth izni", status: bluetoothIzni, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Her zaman yada uygulama açık konum İzni", status: herZamanVeUygulamaYiKullanirkenKonum, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Her zaman konum İzni", status: herZamanKonum, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Uygulamayı kullanırken konum İzni", status: uygulamyiKullanirkenLokasyon, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Galeriye Erişim İzni", status: galeriYeErisim, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Kamera İzni", status: kameraIzni, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Mikrofon İzni", status: mikrofonIzni, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Anımsatıcı İzni", status: animsaticiIzni, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Takvim İzni", status: takvimIzni, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Hareket sensör İzni", status: hareketSensorIzni, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Apple müzik İzni", status: appleMusicErisim, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Galeriye resim ekleme İzni", status: galeriyeResimEkleme, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Yüz tanıma İzni", status: faceIdKullanimi, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Rehbere erişim izni", status: rehbereErisim, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Sesli okuma", status: sesliOkuma, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Destekler", type: ContentType.HEADER))
        appDetails.append(AppDetailModel.init(appHeader: "TV Uygulama Desteği", status: tvUygulamasimi, type: ContentType.HEADER_CONTENT))
        
        appDetails.append(AppDetailModel.init(appHeader: "Arka Plan Modu", type: ContentType.HEADER))
        appDetails.append(AppDetailModel.init(appHeader: "Ses", status: arkaPlanSes, type: ContentType.HEADER_CONTENT))
        appDetails.append(AppDetailModel.init(appHeader: "Lokasyon", status: arkaPlanLokasyon, type: ContentType.HEADER_CONTENT))
        appDetails.append(AppDetailModel.init(appHeader: "Bildirim", status: arkaPlanBildirim, type: ContentType.HEADER_CONTENT))
        appDetails.append(AppDetailModel.init(appHeader: "Fetch", status: arkaPlanFetch, type: ContentType.HEADER_CONTENT))
        appDetails.append(AppDetailModel.init(appHeader: "Bluetooth", status: arkaPlanBleutooth, type: ContentType.HEADER_CONTENT))
        appDetails.append(AppDetailModel.init(appHeader: "Voice IP", status: arkaPlanVoip, type: ContentType.HEADER_CONTENT))
        
        
        appDetails.append(AppDetailModel.init(appHeader: "Http Erişim İzinleri", type: ContentType.HEADER))
        appDetails.append(AppDetailModel.init(appHeader: "Tüm Url'ler Http Erişebilir", status: allowsArbitaryLoads, type: ContentType.HEADER_CONTENT))
        appDetails.append(AppDetailModel.init(appHeader: "Local Url'ler Http Erişebilir", status: localArbitaryLoads, type: ContentType.HEADER_CONTENT))
        
        
        
        
        if domains != nil{
            appDetails.append(AppDetailModel.init(appHeader: "URL Http Ayarları", type: ContentType.HEADER))
            for domain in domains{
                let value = domain.value as? Dictionary<String,Bool>
                if value != nil{
                    for data in value!{
                        if data.key == "NSExceptionAllowsInsecureHTTPLoads"{
                            appDetails.append(AppDetailModel.init(appHeader:"\(domain.key) Http Url izni", status: data.value, type: ContentType.HEADER_CONTENT))
                        }
                        if data.key == "NSIncludesSubdomains"{
                            appDetails.append(AppDetailModel.init(appHeader:"\(domain.key) sub domain erişimi", status: data.value, type: ContentType.HEADER_CONTENT))
                        }
                    }
                }
                
                
            }
            
        }
        if platformDestekleri != nil {
            appDetails.append(AppDetailModel.init(appHeader: "Platformlar", type: ContentType.HEADER))
            for item in platformDestekleri{
                appDetails.append(AppDetailModel.init(appTitle: "", appDetail: item,type: ContentType.CONTENT))
            }
        }
        
        if shortcutItems != nil {
            appDetails.append(AppDetailModel.init(appHeader: "Uygulama 3D Touch Kısa Yolları", type: ContentType.HEADER))
            for item in shortcutItems{
                let obj = item as? Dictionary<String, Any>
                let title = obj?["UIApplicationShortcutItemTitle"] as? String ?? ""
                let type = obj?["UIApplicationShortcutItemType"] as? String ?? ""
                
                appDetails.append(AppDetailModel.init(appTitle: title, appDetail: type,type: ContentType.CONTENT))
            }
        }
        
        
        if fonts != nil {
            appDetails.append(AppDetailModel.init(appHeader: "Fontlar", type: ContentType.HEADER))
            for item in fonts{
                appDetails.append(AppDetailModel.init(appTitle: "", appDetail: item,type: ContentType.CONTENT))
            }
        }
        
        if devices != nil {
            appDetails.append(AppDetailModel.init(appHeader: "Dsteklenen Cihazlar", type: ContentType.HEADER))
            for item in devices{
                appDetails.append(AppDetailModel.init(appTitle: "", appDetail: mapToDevice(identifier: item),type: ContentType.CONTENT))
            }
        }
        
        if deviceFamilys != nil {
            appDetails.append(AppDetailModel.init(appHeader: "Desteklenen Cihaz Aileleri", type: ContentType.HEADER))
            for item in deviceFamilys{
                appDetails.append(AppDetailModel.init(appTitle: "", appDetail: item == 1 ? "Iphone":"Ipad",type: ContentType.CONTENT))
            }
        }
        
        if orientations != nil {
            appDetails.append(AppDetailModel.init(appHeader: "Uygulama Dikey-Yatay Çalışma Durumu", type: ContentType.HEADER))
            for item in orientations{
                if item == "UIInterfaceOrientationPortrait"{
                    appDetails.append(AppDetailModel.init(appTitle: "", appDetail: "Dikey",type: ContentType.CONTENT))
                }else if item == "UIInterfaceOrientationLandscapeLeft"{
                    appDetails.append(AppDetailModel.init(appTitle: "", appDetail: "Yatay Sol",type: ContentType.CONTENT))
                }else if item == "UIInterfaceOrientationLandscapeRight"{
                    appDetails.append(AppDetailModel.init(appTitle: "", appDetail: "Yatay Sağ",type: ContentType.CONTENT))
                }
            }
        }
        
        /*
         //Info plist datası
         appDetails.append(AppDetailModel.init(appHeader: "", type: ContentType.HEADER))
         if appData.containingBundle._infoDictionary != nil {
         
         for (key,value) in appData.containingBundle._infoDictionary.propertyList{
         appDetails.append(AppDetailModel.init(appTitle: key as! String, appDetail: "\(value)",type: ContentType.CONTENT))
         }
         
         }*/
        
        
        return appDetails
    }
    
    static func isVPNConnected() -> Bool {
        let cfDict = CFNetworkCopySystemProxySettings()
        let nsDict = cfDict!.takeRetainedValue() as NSDictionary
        if nsDict["__SCOPED__"]  != nil {
            let keys = nsDict["__SCOPED__"] as! NSDictionary
            
            for key: String in keys.allKeys as! [String] {
                print("key -- "+key)
                if (key == "tap" || key == "tun" || key == "ppp" || key == "ipsec" || key == "ipsec0" || key == "ipsec3" || key == "utun2") {
                    return true
                }
            }
        }
       
        return false
    }
    
    static var appInstallDate: Date {
        if let documentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            if let installDate = try! FileManager.default.attributesOfItem(atPath: documentsFolder.path)[.creationDate] as? Date {
                return installDate
            }
        }
        return Date() // Should never execute
    }
    
    
    static func deviceInfo()  -> Array<AppDetailModel> {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
         var datas = Array<AppDetailModel>()
        datas.append(AppDetailModel.init(appHeader: "Cihaz Bilgisi", type: ContentType.HEADER))
        let deviceId =  UIDevice.current.identifierForVendor?.uuidString
        let systemName = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion
        let identifierManager = ASIdentifierManager.shared()
        let name = UIDevice.current.name
        let defaults = UserDefaults.standard
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        let machineMirror2 = Mirror(reflecting: systemInfo.sysname)
        let systemname = machineMirror2.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        let machineMirror3 = Mirror(reflecting: systemInfo.version)
        let kernelName = machineMirror3.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        UIDevice.current.isBatteryMonitoringEnabled = true
        var batteryLevel: Float {
            return UIDevice.current.batteryLevel
        }
        let isVpn = isVPNConnected()
        datas.append(AppDetailModel.init(appTitle: "Pil Seviyesi", appDetail: "\(batteryLevel*100)",type: ContentType.CONTENT)) //OK

        datas.append(AppDetailModel.init(appTitle: "VPN", appDetail: isVpn ? "Bağlantı Var":"Bağlantı Yok",type: ContentType.CONTENT)) //OK
        datas.append(AppDetailModel.init(appTitle: "Uygulama Kurulum Zamanı", appDetail:formatter.string(from: appInstallDate),type: ContentType.CONTENT))//OK
        datas.append(AppDetailModel.init(appTitle: "Telefon Saati", appDetail:formatter.string(from: Date()),type: ContentType.CONTENT))//OK
        datas.append(AppDetailModel.init(appTitle: "Saat Dilimi", appDetail:TimeZone.current.identifier,type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Model Kimliği", appDetail:identifier,type: ContentType.CONTENT))
       // datas.append(AppDetailModel.init(appTitle: "System Adı", appDetail:systemname,type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Kernel Bilgisi", appDetail:kernelName,type: ContentType.CONTENT))
        let ramTotalSize = CGFloat(ProcessInfo.processInfo.physicalMemory) / (1024.0 * 1024.0 * 1024.0)
        datas.append(AppDetailModel.init(appTitle: "Ram Bilgisi", appDetail:"\(ceil(ramTotalSize)) GB",type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Host Adı", appDetail:"\(ProcessInfo.processInfo.hostName)",type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Process Adı", appDetail:"\(ProcessInfo.processInfo.processName)",type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Globally Unique String", appDetail:"\(ProcessInfo.processInfo.globallyUniqueString)",type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Düşük Güç Modu", appDetail:"\(ProcessInfo.processInfo.isLowPowerModeEnabled ? "Aktif" : "Pasif")",type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Operating System Version", appDetail:"\(ProcessInfo.processInfo.operatingSystemVersionString)",type: ContentType.CONTENT))
         datas.append(AppDetailModel.init(appTitle: "Process Identifier", appDetail:"\(ProcessInfo.processInfo.processIdentifier)",type: ContentType.CONTENT))

        datas.append(AppDetailModel.init(appTitle: "Uygulama ID'si", appDetail: deviceId ?? "-",type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Sistem Adı", appDetail: systemName,type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Model Adı", appDetail: UIDevice.modelName,type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Cihaz Adı", appDetail: name,type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Sistem Versiyon", appDetail: systemVersion,type: ContentType.CONTENT))
        let language = Bundle.main.preferredLocalizations.first ?? "-"
        datas.append(AppDetailModel.init(appTitle: "Cihaz Dili", appDetail: language,type: ContentType.CONTENT))
        let locale = Locale.current.identifier
        datas.append(AppDetailModel.init(appTitle: "Local Dil", appDetail: locale,type: ContentType.CONTENT))
        if identifierManager.isAdvertisingTrackingEnabled {
            let deviceId = identifierManager.advertisingIdentifier.uuidString
            datas.append(AppDetailModel.init(appTitle: "Advertising Identifier", appDetail: deviceId,type: ContentType.CONTENT))
        }
        var passCode = String()
        let reps = defaults.dictionaryRepresentation()
        for (key,value) in reps{
            if key == "ApplePasscodeKeyboards"{
                let obj = (value as? Array<Any>)!
                for item in obj{
                    passCode.append("\(item)\n")
                }
                datas.append(AppDetailModel.init(appTitle: "Klavye Bilgisi", appDetail: "\(passCode)",type: ContentType.CONTENT))
            }else if key == "AppleTemperatureUnit"{
                datas.append(AppDetailModel.init(appTitle: "Sıcaklık Birimi", appDetail: "\(value)",type: ContentType.CONTENT))
            }else if key == "AppleLocale"{
                datas.append(AppDetailModel.init(appTitle: "Apple Locale", appDetail: "\(value)",type: ContentType.CONTENT))
            }
        }      //  datas.append(AppDetailModel.init(appTitle: "Klavye Bilgisi", appDetail: passCode,type: ContentType.CONTENT))

        
        datas.append(AppDetailModel.init(appHeader: "Wifi Bilgisi", type: ContentType.HEADER))
        let mac =  AppListDataSource.wifiMac()
        datas.append(AppDetailModel.init(appTitle: "Wifi Mac Adresi", appDetail: mac,type: ContentType.CONTENT))
        let wifiName =  AppListDataSource.wifiName()
        datas.append(AppDetailModel.init(appTitle: "Wifi Adı", appDetail: wifiName,type: ContentType.CONTENT))
        
        

        
        datas.append(AppDetailModel.init(appHeader: "Hat Bilgisi", type: ContentType.HEADER))
        let phoneNumber = defaults.string(forKey: "SBFormattedPhoneNumber") ?? "-"
        datas.append(AppDetailModel.init(appTitle: "Telefon Numaram", appDetail: phoneNumber, type: ContentType.CONTENT))
        
        var hatDegisikligi = false

        if #available(iOS 12.0, *) {
            networkInfo.serviceSubscriberCellularProvidersDidUpdateNotifier = { carrier in
                DispatchQueue.main.async {
                    print("User did change SIM")
                    hatDegisikligi = true
                }
            }
            let info = networkInfo.serviceSubscriberCellularProviders
            for (_,value) in info!{
                
                datas.append(AppDetailModel.init(appTitle: "Hat Türü", appDetail: value.carrierName ?? "-",type: ContentType.CONTENT))
                datas.append(AppDetailModel.init(appTitle: "Voip", appDetail: value.allowsVOIP ? "Var":"Yok",type: ContentType.CONTENT))
                datas.append(AppDetailModel.init(appTitle: "Ülke Kodu", appDetail: value.isoCountryCode ?? "-",type: ContentType.CONTENT))
                datas.append(AppDetailModel.init(appTitle: "Mobil Ülke Kodu", appDetail: value.mobileCountryCode ?? "-",type: ContentType.CONTENT))
                datas.append(AppDetailModel.init(appTitle: "Ağ Kodu", appDetail: value.mobileNetworkCode ?? "-",type: ContentType.CONTENT))
                
                
            }
            let networkString = networkInfo.serviceCurrentRadioAccessTechnology
            
            for (_,value) in networkString!{
                if value == CTRadioAccessTechnologyLTE{
                    // LTE (4G)
                    datas.append(AppDetailModel.init(appTitle: "Network Türü", appDetail: "LTE",type: ContentType.CONTENT))
                }else if value == CTRadioAccessTechnologyWCDMA{
                    // 3G
                    datas.append(AppDetailModel.init(appTitle: "Network Türü", appDetail: "3G",type: ContentType.CONTENT))
                }else if value == CTRadioAccessTechnologyEdge{
                    datas.append(AppDetailModel.init(appTitle: "Network Türü", appDetail: "EDGE (2G)",type: ContentType.CONTENT))
                }
            }
            
        } else {
            networkInfo.subscriberCellularProviderDidUpdateNotifier = { carrier in
                DispatchQueue.main.async {
                    print("User did change SIM")
                    hatDegisikligi = true
                }
            }
            let info = networkInfo.subscriberCellularProvider
            datas.append(AppDetailModel.init(appTitle: "Hat Türü", appDetail: info?.carrierName ?? "-",type: ContentType.CONTENT))
            datas.append(AppDetailModel.init(appTitle: "Voip", appDetail: info?.allowsVOIP ?? false ? "Var":"Yok",type: ContentType.CONTENT))
            datas.append(AppDetailModel.init(appTitle: "Ülke Kodu", appDetail: info?.isoCountryCode ?? "-",type: ContentType.CONTENT))
            datas.append(AppDetailModel.init(appTitle: "Mobil Ülke Kodu", appDetail: info?.mobileCountryCode ?? "-",type: ContentType.CONTENT))
            datas.append(AppDetailModel.init(appTitle: "Ağ Kodu", appDetail: info?.mobileNetworkCode ?? "-",type: ContentType.CONTENT))
            // Fallback on earlier versions
            let value = networkInfo.currentRadioAccessTechnology
            if value == CTRadioAccessTechnologyLTE{
                // LTE (4G)
                datas.append(AppDetailModel.init(appTitle: "Network Türü", appDetail: "LTE",type: ContentType.CONTENT))
            }else if value == CTRadioAccessTechnologyWCDMA{
                // 3G
                datas.append(AppDetailModel.init(appTitle: "Network Türü", appDetail: "3G",type: ContentType.CONTENT))
            }else if value == CTRadioAccessTechnologyEdge{
                datas.append(AppDetailModel.init(appTitle: "Network Türü", appDetail: "EDGE (2G)",type: ContentType.CONTENT))
            }

        }
        
  
        datas.append(AppDetailModel.init(appTitle: "Hat Değiştimi", appDetail: hatDegisikligi ? "Evet" : "Hayır",type: ContentType.CONTENT))
        
        
        datas.append(AppDetailModel.init(appHeader: "Memory Bilgisi", type: ContentType.HEADER))
        datas.append(AppDetailModel.init(appTitle: "Toplam Cihaz Hafızası", appDetail: UIDevice.current.totalDiskSpaceInGB,type: ContentType.CONTENT))
        
        datas.append(AppDetailModel.init(appTitle: "Boş Cihaz Hafızası", appDetail: UIDevice.current.freeDiskSpaceInGB,type: ContentType.CONTENT))
        datas.append(AppDetailModel.init(appTitle: "Kullanılan Cihaz Hafızası", appDetail: UIDevice.current.usedDiskSpaceInGB,type: ContentType.CONTENT))


        return datas
    }
    
    
}
