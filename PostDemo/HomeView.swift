//
//  HomeView.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/22/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var leftPercent : CGFloat = 0
    
    var body: some View {
        NavigationView{
        
            //可以允许出现两个页面左右滑动的效果
            GeometryReader{ geometry in
                HScrollViewController(pageWidth: geometry.size.width,
                                      contentSize: CGSize(width: geometry.size.width * 2, height: geometry.size.height), leftPercent: self.$leftPercent){
                    HStack(spacing: 0){
                        PostListView(category: .recommand)
                            .frame(width: UIScreen.main.bounds.width)
                        PostListView(category: .hot)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
            }
                .ignoresSafeArea(edges: .bottom)
                .toolbar(content: {
                    HomeNavigationBar(leftPercent: $leftPercent)
                })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    //用过需要用环境对象的地方都要加上environmentObject
    HomeView().environmentObject(UserData())
}
