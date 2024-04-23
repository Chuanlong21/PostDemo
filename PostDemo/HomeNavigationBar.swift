//
//  HomeNavigationBar.swift
//  PostDemo
//
//  Created by Chuanlong Liu on 4/22/24.
//

import SwiftUI


private let kLableWidth : CGFloat = 60
private let kButtonHeight : CGFloat = 24
struct HomeNavigationBar: View {
    
    @Binding var leftPercent : CGFloat // 0 left : 1 right
    

    
    var body: some View {
        
        HStack(alignment: .top, spacing: 0){
            Button (action: {
                print("Click on Camera")
            }){
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.top, 5)
                    .padding(.horizontal, 15)
                    .foregroundStyle(.blue)
            }
            
            Spacer()
            VStack(spacing: 3){
                HStack(spacing: 0){
                    Text("Rec")
                        .bold()
                        .frame(width: kLableWidth, height: kButtonHeight)
                        .padding(.top, 5)
                        .opacity(Double(1 - (self.leftPercent * 0.5)))
                        .onTapGesture {
                            withAnimation{
                                self.leftPercent = 0
                            }
                        }
                    
                    Spacer()
                    
                    Text("Hot")
                        .bold()
                        .frame(width: kLableWidth, height: kButtonHeight)
                        .padding(.top, 5)
                        .opacity(Double(0.5 + self.leftPercent * 0.5 ))
                        .onTapGesture {
                            withAnimation{
                                self.leftPercent = 1
                            }
                            
                        }
                }.font(.system(size: 20))
                
                GeometryReader {geometry in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.blue)
                        .frame(width: 30, height: 4)
                        .offset(x: geometry.size.width * (self.leftPercent - 0.1) + kLableWidth * (0.6 - self.leftPercent))
                    
                }.frame(height: 6)
            }
            .frame(width:  UIScreen.main.bounds.width * 0.5)
            
            Spacer()
            Button (action: {
                print("Click on plus")
            }){
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.top, 5)
                    .padding(.horizontal, 15)
                    .foregroundStyle(.blue)
            }
        }.frame(width: UIScreen.main.bounds.width)
    }
    
}


#Preview {
    HomeNavigationBar(leftPercent: .constant(0))
}
