//
//  BrowserState.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/23.
//

import Foundation

extension AppState {
    struct Browser {
        var items: [BrowserItem] = [.navigation]
        var item: BrowserItem {
            items.filter {
                $0.isSelect
            }.first ?? .navigation
        }
        
        enum Action {
            case refresh, load, back, forward, clean, stop, add, delete, select
        }
    }
}
