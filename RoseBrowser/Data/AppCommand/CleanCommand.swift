//
//  CleanCommand.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/24.
//

import Foundation
import SwiftUI
import SheetKit

struct CleanCommand: AppCommand {
    func execute(in store: Store) {
        var progress = 0.0
        var duration = 12.5
        let subscription = SubscriptionToken()
        Timer.publish(every: 0.01, on: .main, in: .common).autoconnect().sink { _ in
            
            if store.state.root.enterbackground {
                subscription.unseal()
                return
            }
            
            progress += 0.01 / duration
            if progress > 1.0 {
                subscription.unseal()
                store.state.browser.items = [.navigation]
                store.dispatch(.refresh)
                
                store.dispatch(.adShow(.interstitial) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        SheetKit().dismiss {
                                store.dispatch(.alert("Cleaned."))
                        }
                    }
                })
            } else {
                store.dispatch(.degree(progress*360))
            }
            
            if progress > 0.2, store.state.ad.isLoaded(.interstitial) {
                duration = 0.1
            }
        }.seal(in: subscription)
        store.dispatch(.adLoad(.interstitial))

    }
}
