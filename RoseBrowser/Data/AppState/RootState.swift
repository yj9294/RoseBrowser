//
//  RootState.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/23.
//

import Foundation


extension AppState {
    struct Root{
        var selected: Index = .launch
        var adModel: GADNativeViewModel = .None
        var enterbackground = false
        enum Index {
            case launch, home
        }
    }
}
