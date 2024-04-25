//
//  CommentInputView.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/23/24.
//

import SwiftUI

struct CommentInputView: View {
    let post : Post
    @EnvironmentObject var userData : UserData
    @Environment(\.presentationMode) var present
    
    
    @State private var text : String = ""
    @State private var showEmptyText : Bool = false
    var body: some View {
        
        VStack{
            CommentTextView(text: $text, beginEdit: true)
            
            HStack(spacing: 0){
                Button(action: {
                    
                    self.present.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel").padding()
                })
            
                
                Spacer()
                
                Button(action: {
                    
                    if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                        
                        self.showEmptyText = true
                        //设置一段时间过后执行代码
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            self.showEmptyText = false
                        }
                        return
                    }
                            
                    print("\(self.text)")
                    var post = self.post
                    post.commentCount += 1
                    userData.update(post)
                    self.present.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Send").padding()
                })
                
            }.font(.system(size: 18))
                .foregroundStyle(.blue)
        }
        .overlay{
            
            Text("Nothing here yet ...")
                .scaleEffect(showEmptyText ? 1 : 0.5)
                .animation(.spring(duration: 0.5), value: showEmptyText) // Spring animation for scale effect
                .opacity(showEmptyText ? 0.5 : 0)
                .animation(.easeInOut, value: showEmptyText)
           
        }
        
        
    }
}

#Preview {
    let userData = UserData()
    return CommentInputView(post: userData.recommandList.list[0]).environmentObject(userData)
}
