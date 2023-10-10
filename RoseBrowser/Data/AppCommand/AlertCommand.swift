//
//  AlertCommand.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/24.
//

import Foundation
import SwiftUI
import SheetKit

struct AlertCommand: AppCommand {
    
    init(_ message: String) {
        self.message = message
    }
    
    let message: String
    
    @MainActor
    func execute(in store: Store) {
        SheetKit().present(with: .bottomSheet) {
            ZStack {
                Rectangle().fill(.ultraThinMaterial)
                Text(message)
            }.clearBackground()
        }
        Task{
            if !Task.isCancelled {
                try await Task.sleep(nanoseconds: 1_000_000_000)
                SheetKit().dismiss()
            }
        }
    }
}
