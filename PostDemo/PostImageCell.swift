//
//  PostImageCell.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/19/24.
//

import SwiftUI


private let kImageSpace : CGFloat = 6

struct PostImageCell: View {
    let image : [String]
    //自动适应其精度根据不同平台
    let width : CGFloat
    
    var body: some View {
        if image.count == 1{
            loadPicByName(picName: image[0])
                .resizable()
                .scaledToFill()
                //获取屏幕高度完成宽高比 4 ： 3
                .frame(width: width, height: width * 0.75 )
                .clipped()
        }
        else if image.count == 2{
            PostImageCellRow(images: image, width: width)
        }
        else if image.count == 3{
            PostImageCellRow(images: image, width: width)
        }
        else if image.count == 4{
            VStack(spacing: kImageSpace){
                PostImageCellRow(images: Array(image[0...1]), width: width)
                PostImageCellRow(images: Array(image[2...3]), width: width)
            }
        }
        else if image.count == 5{
            VStack(spacing: kImageSpace){
                PostImageCellRow(images: Array(image[0...1]), width: width)
                PostImageCellRow(images: Array(image[2...4]), width: width)
            }
        }
        else if image.count == 6{
            VStack(spacing: kImageSpace){
                PostImageCellRow(images: Array(image[0...2]), width: width)
                PostImageCellRow(images: Array(image[3...5]), width: width)
            }
        }
        
        
    }
}

struct PostImageCellRow : View{
    let images : [String]
    let width : CGFloat
    
    var body: some View {
        HStack(spacing: kImageSpace){
            ForEach(images, id: \.self){ image in
                loadPicByName(picName: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: (self.width - 6 * CGFloat(self.images.count - 1)) / CGFloat(self.images.count) ,
                           height:  (self.width - 6 * CGFloat(self.images.count - 1)) / CGFloat(self.images.count))
                    .clipped()
                
            }
        }
    }
}

#Preview {
    
    let images = postList.list[0].images
    let width = UIScreen.main.bounds.width - 30

    return PostImageCellRow(images: Array(images[0...0]), width: width)
        
   
}
