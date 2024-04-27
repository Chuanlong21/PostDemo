//
//  UserData.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/22/24.
//
import Foundation
import Combine

//环境对象类
//主view所创建的环境对象，所有的子view都可以访问，并且绑定相应的参数
class UserData: ObservableObject{
    //用published来表示需要绑定的参数
    @Published var recommandList : PostList = loadPostListData("PostListData_recommend_1.json")
    @Published var hotList: PostList = loadPostListData("PostListData_hot_1.json")
    @Published var isRefresh : Bool = false
    @Published var isLoadingMore : Bool = false
    @Published var loadingError : Error?
    
    private var recommandDic : [Int : Int] = [:]// id : index
    private var hotDic : [Int : Int] = [:]
    
    init() {
        for i in 0..<recommandList.list.count {
            let post = recommandList.list[i]
            recommandDic[post.id] = i
        }
        
        for i in 0 ..< hotList.list.count {
            let post = hotList.list[i]
            hotDic[post.id] = i
        }
    }
}

extension UserData{
    
    var showLoadingError : Bool {loadingError != nil}
    var loadingErrorText : String {loadingError?.localizedDescription ?? ""}
    
    //参数表示 for（外部参数名） category（内部参数名）：PostListCategory（参数类型）
    func postList(for category : PostListCategory) -> PostList {
        switch category {
        case .hot:
            return hotList
        case .recommand:
            return recommandList
        }
    }
    
    private func handleRefreshPostList(_ list: PostList, for category : PostListCategory){
        var tempList : [Post] = []
        var tempDic : [Int : Int] = [:]
        
        for (index,post) in list.list.enumerated(){
            if tempDic[post.id] != nil{
                continue
            }
            tempList.append(post)
            tempDic[post.id] = index
            
        }
        
        switch category {
        case .hot:
            hotList.list = tempList
            hotDic = tempDic
        case .recommand:
            recommandList.list = tempList
            recommandDic = tempDic
        }
    }
    
    private func handleLoadingError(_ error: Error){
        loadingError = error
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.loadingError = nil
        }
    }
    
    private func handleLoadMorePostList(_ list: PostList, for category : PostListCategory){
        switch category {
        case .recommand:
            for post in list.list{
                if recommandDic[post.id] != nil {continue}
                recommandList.list.append(post)
                recommandDic[post.id] = recommandList.list.count - 1
            }
        case .hot:
            for post in list.list{
                if hotDic[post.id] != nil {continue}
                hotList.list.append(post)
                hotDic[post.id] = hotList.list.count - 1
            }
        }
    }
        
    
    func loadMorePostList(for category : PostListCategory){
        if isLoadingMore || postList(for: category).list.count > 10 {return}
        isLoadingMore = true
        switch category {
        case .recommand:
            NetworkAPI.hotPostList{ result in
                switch result {
                case let .success(list):
                    self.handleLoadMorePostList(list, for: category)
                case let .failure(error):
                    self.handleLoadingError(error)
                }
                self.isLoadingMore = false
            }
            
           
        case .hot:
            NetworkAPI.recommendPostList{ result in
                switch result {
                case let .success(list):
                    self.handleLoadMorePostList(list, for: category)
                case let .failure(error):
                    self.handleLoadingError(error)
                }
                self.isLoadingMore = false
            }
            
        }
    }
    
    func refreshPostList(for category : PostListCategory){
        switch category {
        case .hot:
            NetworkAPI.hotPostList{ result in
                switch result {
                case let .success(list):
                    self.handleRefreshPostList(list, for: category)
                case let .failure(error):
                    self.handleLoadingError(error)
                }
                self.isRefresh = false
            }
        case .recommand:
            NetworkAPI.recommendPostList{ result in
                switch result {
                case let .success(list):
                    self.handleRefreshPostList(list, for: category)
                case let .failure(error):
                    self.handleLoadingError(error)
                }
                self.isRefresh = false
            }
        }
    }
    

    
    func post(forid id : Int ) -> Post?{
        if let index = recommandDic[id] {
            return recommandList.list[index]
        }
        
        if let index = hotDic[id]{
            return hotList.list[index]
        }
        
        return nil
    }
    
    func update(_ post : Post) {
        if let index = recommandDic[post.id]{
            recommandList.list[index] = post
        }
        
        if let index = hotDic[post.id] {
            hotList.list[index] = post
        }
    }
    
}



enum PostListCategory {
    case recommand, hot
}
