//
//  AppAction.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/23.
//

import Foundation

enum AppAction {
    case launch(Bool)
    case background(Bool)
    case launching
    case progress(Double)
    case searchText(String)
    case canGoBack(Bool)
    case canGoForward(Bool)
    case loading(Bool)
    case broserProgress(Double)
    case broserNavigation(Bool)
    case load
    case goBack
    case goForward
    case refresh
    case stopLoad
    case add
    case delete(BrowserItem)
    case select(BrowserItem)
    case showTabView(Bool)
    case showSettingView(Bool)
    case showCleanAlertView(Bool)

    case alert(String)
    
    case share
    case copy
    case rate
    
    case degree(Double)
    case clean
    
    case adRequestConfig
    case adUpdateConfig(GADConfig)
    case adUpdateLimit(GADLimit.Status)
    
    case adAppear(GADPosition)
    case adDisappear(GADPosition)
    
    case adClean(GADPosition)
    
    case adLoad(GADPosition, GADPosition.Position = .home)
    case adShow(GADPosition, GADPosition.Position = .home, ((GADNativeViewModel)->Void)? = nil)
    
    case adNativeImpressionDate(GADPosition.Position = .home)
    
    case adModel(GADNativeViewModel)
    
}
