//
//  Post.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/19/24.
//

import SwiftUI

struct PostList: Codable {
    var list : [Post]
}

//Model
struct Post : Codable, Identifiable{
    let id : Int
    let avatar: String
    let vip: Bool
    let name: String
    let date: String
    var isFollowed: Bool
    
    var text : String
    var images : [String]
    
    var commentCount : Int
    var likeCount : Int
    var isLiked : Bool
    
  
}

extension Post {
    //Calculated Prop
    
    var avatarImage : Image {
        return loadPicByName(picName: avatar)
    }
    
    
    
    var commentCountText : String {
        if commentCount <= 0 {
            return "Comment"
        }
        if commentCount < 1000{
            return "\(commentCount)"
        }else{
            return String(format: "%.1fK", Double(commentCount)/1000)
        }
        
    }
 
    var likeCountText : String {
        if commentCount <= 0 {
            return "Like"
        }
        if commentCount < 1000{
            return "\(likeCount)"
        }else{
            return String(format: "%.1fK", Double(likeCount)/1000)
        }
        
    }
}




func loadPostListData(_ fileName: String) -> PostList{
    guard let url  = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Can't load \(fileName) in main bundle")
    }
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can't load \(url)")
    }
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
        fatalError("Can't decode \(data)")
    }
    return list
}

func loadPicByName( picName: String) -> Image {
    return Image(uiImage: UIImage(named: picName)!)
}
