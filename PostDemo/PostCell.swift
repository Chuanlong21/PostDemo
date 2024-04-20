//
//  PostCell.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/19/24.
//

import SwiftUI

struct PostCell: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 10){
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
                        print("click on follow button")
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
                    print("Click on Comment")
                }
                
                Spacer()
                PostCellToolBarButton(image: "heart",
                                      text: post.likeCountText,
                                      color: .red){
                    print("Click on Like")
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
    PostCell(post: postList.list[0])
}
