//
//  PostCellToolBarButton.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/19/24.
//

import SwiftUI

struct PostCellToolBarButton: View {
    
    let image : String
    let text : String
    let color : Color
    let action : () -> Void
    
    var body: some View {
        Button(action : action, label: {
            HStack(spacing:5){
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                
                Text(text).font(.system(size: 15))
            }
        }).foregroundColor(color)
            .buttonStyle(BorderlessButtonStyle())
    }
}

#Preview {
    PostCellToolBarButton(image: "heart", text: "Like", color: .red){
        print("Liked")
    }
}
