//
//  PostListView.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/19/24.
//

import SwiftUI

struct PostListView: View {
    var body: some View {
        
        List{
            //只有post遵循identifiable的协议，id这个属性才能省略
            ForEach(postList.list){ post in
                PostCell(post: post)
                    .listRowInsets(EdgeInsets())
                  
            }
        }.listStyle(PlainListStyle()) 
            
        
    }
}

#Preview {
    PostListView()
}
