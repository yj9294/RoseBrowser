//
//  Store.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/23.
//

import Foundation
import Combine

class Store: ObservableObject {
    @Published var state = AppState()
    var publishers = [AnyCancellable]()
    init() {
        dispatch(.launching)
        dispatch(.adRequestConfig)
    }
    func dispatch(_ action: AppAction) {
        let result = Store.reduce(state, action: action)
        state = result.0
        let command = result.1
        command?.execute(in: self)
    }
}

extension Store {
    static func reduce(_ state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var command: AppCommand? = nil
        switch action {
        case .background(let isBackground):
            appState.root.enterbackground = isBackground
        case .progress(let progress):
            appState.launch.progress = progress > 1.0 ? 1.0 : progress; 
        case .launch(let isLaunched):
            appState.root.selected = isLaunched ? .home : .launch
        case .launching:
            command = LaunchCommand()
        case .load:
            command = BrowserCommand(.load)
        case .goBack:
            command = BrowserCommand(.back)
        case .goForward:
            command = BrowserCommand(.forward)
        case .refresh:
            command = BrowserCommand(.refresh)
        case .stopLoad:
            command = BrowserCommand(.stop)
            
        case .searchText(let text):
            appState.home.searchText = text
        case .canGoBack(let canGoBack):
            appState.home.canGoBack = canGoBack
        case .canGoForward(let canGoForward):
            appState.home.canGoForword = canGoForward
        case .broserProgress(let progress):
            appState.home.progress = progress
        case .broserNavigation(let isNavigaiton):
            appState.home.isNavigation = isNavigaiton
        case .loading(let isLoading):
            appState.home.isLoading = isLoading

        case .select(let item):
            command = BrowserCommand(.select, item)
        case .delete(let item):
            command = BrowserCommand(.delete, item)
        case .add:
            command = BrowserCommand(.add)
        case .showTabView(let isShow):
            appState.home.showTabView = isShow
        case .showSettingView(let isShow):
            appState.home.showSettingView = isShow
        case .showCleanAlertView(let isShow):
            appState.home.showCleanAlertView = isShow
            
        case .alert(let message):
            command = AlertCommand(message)
        case .share:
            command = SettingCommand(.share)
        case .copy:
            command = SettingCommand(.copy)
        case .rate:
            command = SettingCommand(.rate)
            
        case .clean:
            command = CleanCommand()
        case .degree(let degree):
            appState.clean.degree = degree
            
            
        case .adRequestConfig:
            command = GADRemoteConfigCommand()
        case .adUpdateConfig(let config):
            appState.ad.config = config
        case .adUpdateLimit(let state):
            command = GADUpdateLimitCommand(state)
        case .adAppear(let position):
            command = GADAppearCommand(position)
        case .adDisappear(let position):
            command = GADDisappearCommand(position)
        case .adClean(let position):
            command = GADCleanCommand(position)
        
        case .adLoad(let position, let p):
            command = GADLoadCommand(position, p)
        case .adShow(let position, let p, let completion):
            command = GADShowCommand(position, p, completion)
            
        case .adNativeImpressionDate(let p):
            appState.ad.impressionDate[p] = Date()
        case .adModel(let model):
            appState.root.adModel = model
        }
        return (appState, command)
    }
    
}
