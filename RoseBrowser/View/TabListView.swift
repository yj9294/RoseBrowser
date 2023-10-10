//
//  TabListView.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/24.
//

import SwiftUI
import SheetKit

struct TabListView: View {
    
    @EnvironmentObject var store: Store
    
    let colums = [GridItem(.flexible()), GridItem(.flexible()),]
    
    let radio = 204.0 / 158.0
    
    var dataSource: [BrowserItem] {
        store.state.browser.items
    }

    var body: some View {
        GeometryReader{ proxy in
            VStack{
                ScrollView {
                    LazyVGrid(columns: colums) {
                        let width = (proxy.size.width - 48) / 2.0
                        ForEach(dataSource, id: \.self) { item in
                            ZStack{
                                Button {
                                    select(item)
                                } label: {
                                    item.isSelect ? Color("#4074E1") : Color.white
                                }
                                
                                VStack{
                                    HStack{
                                        Spacer()
                                        Button {
                                            delete(item)
                                        } label: {
                                            Image("close")
                                        }
                                    }
                                    Spacer()
                                }.opacity(dataSource.count == 1 ? 0.0 : 1.0)
                                Text(item.url).foregroundColor(item.isSelect ? Color.white : Color.black).padding(.horizontal, 10).multilineTextAlignment(.center)
                            }.cornerRadius(12).frame(width: width, height: width * radio)
                        }
                    }.padding(.all, 16)
                }
                Spacer()
                VStack{
                    NativeView(model: store.state.root.adModel)
                }.padding(.horizontal, 20).frame(height: 76).padding(.vertical, 20)
                ZStack {
                    HStack{
                        Button(action: dismiss) {
                            Image("back").padding(.leading, 16)
                        }
                        Spacer()
                    }
                    Button(action: add) {
                        Image("add")
                    }
                }
            }.background()
        }.onAppear{
            store.dispatch(.showTabView(true))
            store.dispatch(.adLoad(.native, .tab))
        }
    }
}

extension TabListView {
    func dismiss() {
        store.dispatch(.adDisappear(.native))
        SheetKit().dismiss() {
            store.dispatch(.showTabView(false))
        }
    }
    
    func delete(_ item: BrowserItem) {
        store.dispatch(.delete(item))
        store.dispatch(.refresh)
    }
    
    func add() {
        dismiss()
        store.dispatch(.add)
        store.dispatch(.refresh)
    }
    
    func select(_ item: BrowserItem) {
        dismiss()
        store.dispatch(.select(item))
        store.dispatch(.refresh)
    }
}

struct TabListView_Previews: PreviewProvider {
    static var previews: some View {
        TabListView().environmentObject(Store())
    }
}
