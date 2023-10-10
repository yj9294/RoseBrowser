//
//  Modifier.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/24.
//

import Foundation
import SwiftUI


struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content.background(.linearGradient( Gradient(colors: [Color("#B8F7FF"), Color("#FFFFFF")]), startPoint: .top, endPoint: .bottom))
    }
}

extension View {
    func background() -> some View {
        self.modifier(BackgroundModifier())
    }
}
