//
//  BrowserCommand.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/23.
//

import Foundation

class BrowserCommand: AppCommand {
    
    init(_ action: AppState.Browser.Action, _ item: BrowserItem = .navigation) {
        self.action = action
        self.item = item
    }
    
    let action: AppState.Browser.Action
    var item: BrowserItem
    func execute(in store: Store) {
        let text = store.state.home.searchText
        let webView = store.state.browser.item.webView
        switch action {
        case .load:
            if text.count > 0 {
                store.state.browser.item.load(text)
                store.dispatch(.refresh)
            } else {
                store.dispatch(.alert("Please enter your search content."))
            }
        case .stop:
            webView.stopLoading()
        case .back:
            webView.goBack()
        case .forward:
            webView.goForward()
        case .clean:
            break
        case .refresh:
            store.dispatch(.searchText(""))
            
            
            let goback = webView.publisher(for: \.canGoBack).sink { canGoBack in
                store.dispatch(.canGoBack(canGoBack))
            }
            
            let goForword = webView.publisher(for: \.canGoForward).sink { canGoForword in
                store.dispatch(.canGoForward(canGoForword))
            }
            
            let isLoading = webView.publisher(for: \.isLoading).sink { isLoading in
                store.dispatch(.loading(isLoading))
            }
            
            let progress = webView.publisher(for: \.estimatedProgress).sink { progress in
                store.dispatch(.broserProgress(progress))
                store.dispatch(.loading(progress != 1.0 && progress != 0.0))
            }
            
            let isNavigation = webView.publisher(for: \.url).map{$0 == nil}.sink { isNavigation in
                store.dispatch(.broserNavigation(isNavigation))
                store.dispatch(.searchText(isNavigation ? "" : (webView.url?.absoluteString ?? "")))
            }
            
            let url = webView.publisher(for: \.url).compactMap{$0}.sink { url in
                store.dispatch(.searchText(url.absoluteString))
            }
            store.publishers = [goback, goForword, progress, isLoading, isNavigation, url]
        case .add:
            store.state.browser.items.forEach({$0.isSelect = false})
            store.state.browser.items.insert(.navigation, at: 0)
        case .delete:
            if item.isSelect {
                store.state.browser.items = store.state.browser.items.filter({
                    !$0.isSelect
                })
                store.state.browser.items.first?.isSelect = true
            } else {
                store.state.browser.items = store.state.browser.items.filter({
                    $0 != item
                })
            }
        case .select:
            store.state.browser.items.forEach {
                $0.isSelect = false
            }
            item.isSelect = true
        }
    }
}
