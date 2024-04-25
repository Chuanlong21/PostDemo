//
//  PostDetailView.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/22/24.
//

import SwiftUI

struct PostDetailView: View {
    
    let post : Post
    var body: some View {
        List{
            PostCell(post: post)
                .listRowInsets(EdgeInsets())
            ForEach(1...10, id: \.self){ i in
                Text("Comment \(i)")
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    let userData = UserData()
    return PostDetailView(post: userData.recommandList.list[0]).environmentObject(userData)
}
