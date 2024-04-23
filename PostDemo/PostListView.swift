//
//  PostListView.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/19/24.
//

import SwiftUI

struct PostListView: View {
    let category : PostListCategory
    
    var postList : PostList {
        switch category {
        case .recommand:
            return loadPostListData("PostListData_recommend_1.json")
        case .hot:
            return loadPostListData("PostListData_hot_1.json")
        }
    }
    
    
    var body: some View {
         
        List{
            //只有post遵循identifiable的协议，id这个属性才能省略
            ForEach(postList.list){ post in
                
                //用来消除navigation的右滑小按钮
                ZStack{
                    PostCell(post: post)
                    NavigationLink(destination: PostDetailView(post: post)){
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .opacity(0)  // 完全隐藏 NavigationLink
                }
               .listRowInsets(EdgeInsets())
              
                  
            }
        }.listStyle(PlainListStyle()) 
            
        
    }
}

#Preview {
    NavigationView{
        PostListView(category: .recommand)
            .navigationTitle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Title@*/Text("Title")/*@END_MENU_TOKEN@*/)
            .toolbar(.hidden)
    }
    
}
