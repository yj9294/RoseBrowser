//
//  WebView.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/23.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let webView: WKWebView
    func makeUIView(context: Context) -> some UIView {
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
