//
//  LaunchView.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/23.
//

import SwiftUI

struct LaunchView: View {
    init(_ progress: Double) {
        self.progress = progress
    }
    
    let progress: Double;
    var body: some View {
        VStack{
            VStack(spacing: 18){
                Image("launch_icon")
                Image("launch_title")
            }.padding(.top, 105)
            Spacer()
            HStack{
                ProgressView(value: progress, total: 1.0)
            }.padding(.horizontal, 80).padding(.bottom, 80)
        }.background()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(0.5)
    }
}
