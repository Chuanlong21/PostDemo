//
//  PostCell.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/19/24.
//

import SwiftUI

struct PostCell: View {
    let post: Post
    
    
    
    var bindingPost: Post {
        userData.post(forid: post.id)!
    }
    
    
    @State var present : Bool = false
    //绑定环境对象
    @EnvironmentObject var userData : UserData

    var body: some View {
        
        var post = bindingPost
        return VStack(alignment: .leading, spacing: 10){
            HStack(spacing: 5){
                post.avatarImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(
                        PostVIPBadge(vip : post.vip)
                            .offset(x : 16, y : 16)
                    )
                
                
                VStack(alignment: .leading, spacing: 5){
                    Text(post.name)
                        .font(Font.system(size: 16))
                        .foregroundStyle(Color(red: 242/255, green: 99/255,blue: 4/255))
                        .lineLimit(1)
                    Text(post.date)
                        .font(.system(size: 11))
                        .foregroundStyle(.gray)
                }
                .padding(.leading, 10)
                
                if !post.isFollowed {
                    Spacer()
                    Button(action: {
                        post.isFollowed = true
                        self.userData.update(post)
                    }, label: {
                        Text("Follow")
                            .font(.system(size: 14))
                            .foregroundStyle(.blue)
                            .frame(width: 50, height: 26)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(.blue, lineWidth: 1)
                            )
                    }).buttonStyle(BorderlessButtonStyle())
                }
                
            }
            
            Text(post.text)
                .font(.system(size: 17))
            
            if !post.images.isEmpty {
                //图片设置模版
//                loadPicByName(picName: post.images[0])
//                    .resizable()
//                    .scaledToFill()
//                    //获取屏幕高度完成宽高比 4 ： 3
//                    .frame(width: UIScreen.main.bounds.width - 30, height: (UIScreen.main.bounds.width - 30) * 0.75 )
//                    .clipped()
                
                PostImageCell(image: post.images, width: UIScreen.main.bounds.width - 30)
            }
            
            Divider()
            
            HStack(spacing:0){
                Spacer()
                PostCellToolBarButton(image: "message",
                                      text: post.commentCountText,
                                      color: .black){
                    self.present = true
                }.sheet(isPresented: $present){
                    CommentInputView(post: post).environmentObject(self.userData)
                }
                
                Spacer()
                PostCellToolBarButton(image: post.isLiked ? "heart.fill" : "heart",
                                      text: post.likeCountText,
                                      color: post.isLiked ? .red : .black){
                    if post.isLiked {
                        
                        post.isLiked = false
                        post.likeCount -= 1
                        
                    }else {
                        
                        
                        post.isLiked = true
                        post.likeCount += 1
                        
                        if post.likeCountText == "Like"{
                            
                        }
                    }
                    self.userData.update(post)
                }
                Spacer()
            }
            Rectangle()
                .padding(.horizontal,-15)
                .frame(height: 10)
                .foregroundStyle(Color(red:238/255, green: 238/255, blue: 238/255))
        }
        .padding(.horizontal, 15)
        .padding(.top,15)
        
    }
}

#Preview {
    let userData = UserData()
    return PostCell(post: userData.recommandList.list[0]).environmentObject(userData)
}
