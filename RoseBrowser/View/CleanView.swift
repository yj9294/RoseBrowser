//
//  CleanView.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/24.
//

import SwiftUI

struct CleanView: View {
    @EnvironmentObject var store: Store
    var degreen: Double {
        store.state.clean.degree
    }
    var body: some View {
        VStack{
            HStack{Spacer()}
            Spacer()
            VStack(spacing: 132){
                ZStack{
                    Image("rotate").rotationEffect(.degrees(degreen))
                    Image("clean 2")
                }
                Text("Cleaning").foregroundColor(.black)
            }
            Spacer()
        }.background()
    }
}

struct CleanView_Previews: PreviewProvider {
    static var previews: some View {
        CleanView().environmentObject(Store())
    }
}
