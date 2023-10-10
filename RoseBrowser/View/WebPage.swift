//
//  WebPage.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/24.
//

import SwiftUI
import SheetKit

struct WebPage: View {
    let item: AppState.Setting.WebPageIndex
    init(_ item: AppState.Setting.WebPageIndex) {
        self.item = item
    }
    var body: some View {
        VStack{
            ZStack{
                Text(item.title).foregroundColor(.black)
                HStack{
                    Button(action: dismiss) {
                        Image("back_1")
                    }.padding(.leading, 16)
                    Spacer()
                }
            }
            Spacer()
            ScrollView{
                VStack {
                    HStack{
                        Text(item.body)
                        Spacer()
                    }
                    Spacer()
                }
            }.padding(.all, 16)
        }.background()
    }
}

extension WebPage {
    
    func dismiss() {
        SheetKit().dismiss()
    }
}

struct WebPage_Previews: PreviewProvider {
    static var previews: some View {
        WebPage(.privacy)
    }
}
