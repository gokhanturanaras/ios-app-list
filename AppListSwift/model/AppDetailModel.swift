//
//  AppDetailModel.swift
//  AppListSwift
//
//  Created by Gökhan on 5.07.2019.
//  
//

import Foundation


enum ContentType {
    case CONTENT
    case HEADER
    case HEADER_CONTENT
}

struct AppDetailModel {
    var appTitle:String!
    var appDetail:String!
    var appHeader:String!
    var status:Bool!
    var type:ContentType!
    init() {}
    
    init(appTitle:String, appDetail:String,type:ContentType) {
        self.appDetail = appDetail
        self.appTitle = appTitle
        self.type = type
    }
    
    init(appHeader:String,type:ContentType) {
        self.appHeader = appHeader
        self.type = type
    }
    
    init(appHeader:String,status:Bool,type:ContentType) {
        self.appHeader = appHeader
        self.status = status
        self.type = type
    }
}
