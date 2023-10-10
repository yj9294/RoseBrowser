//
//  SettingCommand.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/24.
//

import Foundation
import SheetKit
import SwiftUI
import UniformTypeIdentifiers

let AppUrl = "https://itunes.apple.com/cn/app/id6468958597"

struct SettingCommand: AppCommand {
    let action: AppState.Setting.Index
    
    init(_ action: AppState.Setting.Index) {
        self.action = action
    }
    
    func execute(in store: Store) {
        switch action {
        case .share:
            SheetKit().present {
                ShareViwe(url: store.state.home.isNavigation ? AppUrl : store.state.browser.item.url)
            }
        case .copy:
            UIPasteboard.general.setValue(store.state.home.searchText, forPasteboardType: UTType.plainText.identifier)
            store.dispatch(.alert("Cope successfully."))
        case .rate:
            OpenURLAction { URL in
                .systemAction(URL)
            }.callAsFunction(URL(string: AppUrl)!)
        default:break
        }
    }
}
