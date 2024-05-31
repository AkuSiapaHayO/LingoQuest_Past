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
    let rectangleSize: CGFloat
    let text: String
    let size: CGFloat
    let backgroundRectangle: LinearGradient
    let shadow: Color
    let stroke: Color
    let paddingStart: CGFloat
    let paddingEnd: CGFloat
    let backgroundBox: LinearGradient
    let topBottomPadding: CGFloat
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: spacing) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: rectangleSize, height: rectangleSize)
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
                        Font.custom("Poppins", size: size)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
            .padding(.top, topBottomPadding)
            .padding(.bottom, topBottomPadding)
            .padding(.leading, paddingStart)
            .padding(.trailing, paddingEnd)
            .background(backgroundBox)
            .clipShape(RoundedRectangle(cornerRadius: 90))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
