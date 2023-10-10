//
//  HomeState.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/23.
//

import Foundation

extension AppState {
    struct Home {
        
        var searchText: String = ""
        var isLoading: Bool = false
        var canGoBack: Bool = false
        var canGoForword: Bool = false
        var isNavigation: Bool = true
        var progress: Double = 0.0
        var showTabView: Bool = false
        var showSettingView: Bool = false
        var showCleanAlertView: Bool = false
        
        enum Index: String, CaseIterable {
            case  facebook, google,youtube, twitter, instagram, amazon,  tiktok, yahoo
            var title: String {
                return "\(self)".capitalized
            }
            var url: String {
                return "https://www.\(self).com"
            }
            var icon: String {
                return "\(self)"
            }
        }
    }
}
