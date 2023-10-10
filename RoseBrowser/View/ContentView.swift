//
//  ContentView.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    var progress: Double {
        store.state.launch.progress
    }
    var body: some View {
        TabView(selection: $store.state.root.selected) {
            LaunchView(progress).tag(AppState.Root.Index.launch)
            HomeView().tag(AppState.Root.Index.home)
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            willEnterForeground()
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            didEnterBackground()
        }.onReceive(NotificationCenter.default.publisher(for: .nativeAdLoadCompletion)) { noti in
            if let ad = noti.object as? GADNativeViewModel {
                store.dispatch(.adModel(ad))
            } else {
                store.dispatch(.adModel(.None))
            }
        }
    }
}


extension ContentView {
    
    func willEnterForeground() {
        store.dispatch(.background(false))
        dismiss()
        store.dispatch(.launch(false))
        store.dispatch(.launching)
    }
    
    func didEnterBackground() {
        store.dispatch(.background(true))
        store.dispatch(.launch(false))
        store.dispatch(.adDisappear(.native))
    }
    
    func dismiss() {
        if let scene = UIApplication.shared.connectedScenes.filter({$0 is UIWindowScene}).first as? UIWindowScene, let keyWindow = scene.keyWindow,  let rootVC = keyWindow.rootViewController {
            if let presented = rootVC.presentedViewController {
                if let presentedPresented = presented.presentedViewController {
                    presentedPresented.dismiss(animated: true) {
                        presented.dismiss(animated: true)
                    }
                } else {
                    presented.dismiss(animated: true) {
                        rootVC.dismiss(animated: true)
                    }
                }
            } else {
                rootVC.dismiss(animated: true)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store())
    }
}
