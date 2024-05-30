//
//  Button.swift
//  LingoQuest
//
//  Created by Dhiaz Ramadhan on 31/05/24.
//

import SwiftUI

struct CustomButton: View {
    let action: () -> Void
    let spacing: CGFloat
    let text: String
    let backgroundRectangle: LinearGradient
    let shadow: Color
    let stroke: Color
    let backgroundBox: LinearGradient
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: spacing) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 30, height: 30)
                    .background(backgroundRectangle)
                    .cornerRadius(10)
                    .shadow(color: shadow, radius: 5, x: 0, y: 0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .inset(by: 2)
                            .stroke(stroke, lineWidth: 4)
                    )
                
                Text(text)
                    .font(
                        Font.custom("Poppins", size: 24)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            .padding(.leading, 70)
            .padding(.trailing, 70)
            .background(backgroundBox)
            .clipShape(RoundedRectangle(cornerRadius: 90))
        }
    }
}
