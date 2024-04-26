//
//  PostListView.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/19/24.
//

import SwiftUI
import BBSwiftUIKit

struct PostListView: View {
    let category : PostListCategory
    
    @EnvironmentObject var userData : UserData
    
    var body: some View {
         
        BBTableView(userData.postList(for: category).list){ post in
            
            NavigationLink(destination: PostDetailView(post: post)){
                PostCell(post: post)
            }
            .buttonStyle(OriginalButtonStyle())
             
        }
        .bb_setupRefreshControl{ control in
            control.attributedTitle = NSAttributedString(string: "Loading...")
        }
        .bb_pullDownToRefresh(isRefreshing: $userData.isRefresh){
            print("Refresh")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.userData.isRefresh = false
            }
        }
        .bb_pullUpToLoadMore(bottomSpace: 30){
            if self.userData.isLoadingMore {return}
            else {
                self.userData.isLoadingMore = true
            }
            print("Load More")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.userData.isLoadingMore = false
            }
        }
        .overlay(
            Text(self.userData.loadingErrorText)
            .bold()
            .frame(width: 200)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.white)
                    .opacity(0.8)
                
            )
//            .animation(nil)
            .scaleEffect(self.userData.showLoadingError ? 1 : 0.5)
            .animation(.spring(duration: 0.5), value: self.userData.showLoadingError)
            .opacity(self.userData.showLoadingError ? 0.5 : 0)
            .animation(.easeInOut, value: self.userData.showLoadingError)
        )
            
        
    }
}

#Preview {
    NavigationView{
        PostListView(category: .recommand)
            .navigationTitle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Title@*/Text("Title")/*@END_MENU_TOKEN@*/)
            .toolbar(.hidden)
    }
    .environmentObject(UserData())
}

