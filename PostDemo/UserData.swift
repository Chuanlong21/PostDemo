//
//  UserData.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/22/24.
//
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
