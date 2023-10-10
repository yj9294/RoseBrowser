//
//  HomeView.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/23.
//

import SwiftUI
import SheetKit

struct HomeView: View {
    
    @EnvironmentObject var store: Store
        
    var progress: Double {
        store.state.home.progress
    }
    
    var isLoading: Bool {
        store.state.home.isLoading
    }
    
    var canGoBack: Bool {
        store.state.home.canGoBack
    }
    
    var canGoForward: Bool {
        store.state.home.canGoForword
    }
    
    var count: Int {
        store.state.browser.items.count
    }
    
    var showTab: Bool {
        store.state.home.showTabView
    }
    
    var showSetting: Bool {
        store.state.home.showSettingView
    }
    
    var showAlert: Bool {
        store.state.home.showCleanAlertView
    }
        
    let colums = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    
    var body: some View {
        ZStack {
            VStack{
                VStack{
                    HStack{
                        TextField("", text: $store.state.home.searchText, prompt: Text("Search or enter URL").foregroundColor(Color("#9E9E9E"))).padding(.all, 18)
                        Button(action: {
                            isLoading ? stopSearch() : search()
                        }, label: {
                            Image(!isLoading ? "search" : "stop_search")
                        }).padding(.trailing, 12)
                    }.background(RoundedRectangle(cornerRadius: 28).stroke(Color("#4074E1")))
                }.padding(.top, 20).padding(.horizontal, 28)
                ZStack{
                    Color("#B29EA4").opacity(0.4)
                    GeometryReader() { proxy in
                        Color("#B29EA4").padding(.trailing, proxy.size.width * (1 - progress))
                    }
                }.frame(height: 2).opacity(store.state.home.isLoading ? 1.0 : 0.0)
                Spacer()
                VStack{
                    if store.state.browser.item.isNavigation {
                        VStack {
                            Spacer()
                            LazyVGrid(columns: colums) {
                                ForEach(AppState.Home.Index.allCases, id: \.self) { item in
                                    Button(action: {
                                        store.dispatch(.searchText(item.url))
                                        search()
                                    }, label: {
                                        VStack(spacing: 12){
                                            Image(item.icon)
                                            Text(item.title)
                                                .foregroundColor(Color("#333333"))
                                                .font(.system(size: 13.0))
                                        }
                                    })
                                }
                            }
                            Spacer()
                            if !showTab {
                                VStack{
                                    NativeView(model: store.state.root.adModel)
                                }.padding(.horizontal, 20).frame(height: 76)
                            }
                            Spacer()
                        }
                    } else if !showTab {
                        WebView(webView: store.state.browser.item.webView)
                    }
                }
                Spacer()
                HStack{
                    Button(action: back) {
                        Image("arrow_left").opacity(canGoBack ? 1.0 : 0.5)
                    }
                    Spacer()
                    Button(action: forward) {
                        Image("arrow_right").opacity(canGoForward ? 1.0 : 0.5)
                    }
                    Spacer()
                    Button(action: clean) {
                        Image("clean")
                    }
                    Spacer()
                    Button(action: tab) {
                        ZStack {
                            Image("tab")
                            Text("\(count)").foregroundColor(.black).font(.system(size: 13.0))
                        }
                    }
                    Spacer()
                    Button(action: setting) {
                        Image("setting")
                    }
                }.padding(.horizontal, 20)
            }
            if showSetting {
                getSettingView()
            }
            if showAlert {
                getCleanAlertView()
            }
        }.background().onAppear{
            store.dispatch(.adLoad(.interstitial))
            store.dispatch(.adLoad(.native))
        }
    }
    
    func getSettingView() -> some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                VStack{
                    HStack{
                        Button(action: new) {
                            Row(item: .new)
                        }
                        Spacer()
                        Button(action: share) {
                            Row(item: .share)
                        }
                        Spacer()
                        Button(action: copy) {
                            Row(item: .copy)
                        }
                    }.padding(.horizontal, 18).padding(.top, 10)
                    Button(action: rate) {
                        Column(item: .rate)
                    }
                    Button(action: terms) {
                        Column(item: .terms)
                    }
                    Button(action: privacy) {
                        Column(item: .privacy)
                    }
                }.padding(.bottom, 15).background(RoundedRectangle(cornerRadius: 12).fill(Color("#B8F7FF"))).padding(.leading, 76).padding(.trailing, 20)
            }
        }.background(Color.black.opacity(0.4).ignoresSafeArea().onTapGesture {
            store.dispatch(.showSettingView(false))
        })
    }
    
    func getCleanAlertView() -> some View {
        VStack{
            Spacer()
            VStack(spacing: 20){
                HStack{Spacer()}
                Image("clean 1")
                Text("Close Tabs and Clear Data").font(.system(size: 14.0))
                Button(action: showClean) {
                    Text("Confirm").foregroundColor(.white).padding(.horizontal, 70).padding(.vertical, 14).background(RoundedRectangle(cornerRadius: 22).fill(.linearGradient( Gradient(colors: [Color("#4775D7"), Color("#CD33FF")]), startPoint: .leading, endPoint: .trailing)))
                }
            }.padding(.vertical, 20).background(RoundedRectangle(cornerRadius: 12).fill(Color.white)).padding(.horizontal, 40)
            Spacer()
        }.background(Color.black.opacity(0.4).ignoresSafeArea().onTapGesture {
            store.dispatch(.showCleanAlertView(false))
        })
    }
    
    struct Row: View {
        let item: AppState.Setting.Index
        var body: some View {
            VStack(spacing: 5){
                Image(item.rawValue)
                Text(item.title).foregroundColor(Color.black).font(.system(size: 14.0)).foregroundColor(Color.black)
            }.padding(.all, 10)
        }
    }
    
    struct Column: View {
        let item: AppState.Setting.Index
        var body: some View {
            HStack{
                Text(item.title).font(.system(size: 13.0)).foregroundColor(Color.black)
                Spacer()
                Image("next")
            }.padding(.horizontal, 18).padding(.vertical, 12).background(RoundedRectangle(cornerRadius: 8).fill(Color.white)).padding(.horizontal, 15)
        }
    }
}

extension HomeView {
    func search() {
        store.dispatch(.load)
    }
    
    func stopSearch() {
        store.dispatch(.stopLoad)
    }
    
    func back() {
        store.dispatch(.goBack)
    }
    
    func forward() {
        store.dispatch(.goForward)
    }
    
    func clean() {
        store.dispatch(.showCleanAlertView(true))
    }
    
    func tab() {
        store.dispatch(.adDisappear(.native))
        SheetKit().present(with: .fullScreenCover) {
            TabListView().environmentObject(store)
        }
    }
    
    func setting() {
        store.dispatch(.showSettingView(true))
    }
}


extension HomeView {
    
    func new() {
        store.dispatch(.showSettingView(false))
        store.dispatch(.add)
        store.dispatch(.refresh)
    }
    
    func share() {
        store.dispatch(.showSettingView(false))
        store.dispatch(.share)
    }
    
    func copy() {
        store.dispatch(.showSettingView(false))
        store.dispatch(.copy)
    }
    
    func rate() {
        store.dispatch(.showSettingView(false))
        store.dispatch(.rate)
    }
    
    func privacy() {
        store.dispatch(.adDisappear(.native))
        store.dispatch(.showSettingView(false))
        SheetKit().present(with: .fullScreenCover) {
            WebPage(.privacy)
        }
    }
    
    func terms() {
        store.dispatch(.adDisappear(.native))
        store.dispatch(.showSettingView(false))
        SheetKit().present(with: .fullScreenCover) {
            WebPage(.terms)
        }
    }
    
    func showClean() {
        store.dispatch(.adDisappear(.native))
        store.dispatch(.showCleanAlertView(false))
        store.dispatch(.clean)
        SheetKit().present(with: .fullScreenCover) {
            CleanView().environmentObject(store)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Store())
    }
}
