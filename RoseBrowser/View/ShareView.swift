//
//  ShareView.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/24.
//

import Foundation
import SwiftUI

struct ShareViwe: UIViewControllerRepresentable {
    let url: String
    func makeUIViewController(context: Context) -> some UIViewController {
        return UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
