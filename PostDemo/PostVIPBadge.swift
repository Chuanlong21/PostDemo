//
//  PostVIPBadge.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/19/24.
//

import SwiftUI

struct PostVIPBadge: View {
    let vip : Bool
    var body: some View {
        Group{
            if vip {
                Text("V")
                    .bold()
                    .font(.system(size: 11))
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.yellow)
                    .background(.blue)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7.5)
                            .stroke(.white, lineWidth: 1)
                    )
            }
            
        }
       
    }
}

#Preview {
    PostVIPBadge(vip: true)
}
