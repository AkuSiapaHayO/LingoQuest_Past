//
//  Home.swift
//  LingoQuest
//
//  Created by Dhiaz Ramadhan on 31/05/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack(alignment: .center, spacing: 90) {
            VStack {
                Text("Welcome To")
                    .font(
                        Font.custom("Poppins", size: 32)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: 211, height: 43, alignment: .top)
                
                Text("LingoQuest")
                    .font(
                        Font.custom("Poppins", size: 40)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: 241, height: 55, alignment: .top)
            }
            
            VStack(spacing: 15) {
                CustomButton(
                    action: {
                        print("Button tapped!")
                    },
                    spacing: 35,
                    text: "Crossword",
                    backgroundRectangle: LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.92, green: 0.97, blue: 1), location: 0.17),
                            Gradient.Stop(color: Color(red: 1, green: 0.14, blue: 0.14), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.49, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    ),
                    shadow: Color(red: 0, green: 0.16, blue: 0.48).opacity(0.25),
                    stroke: Color(red: 0.81, green: 0.24, blue: 0.24),
                    backgroundBox: LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.27),
                            Gradient.Stop(color: Color(red: 1, green: 0, blue: 0), location: 0.59),
                        ],
                        startPoint: UnitPoint(x: 0.86, y: -3.28),
                        endPoint: UnitPoint(x: 0.86, y: 4.27)
                    )
                )
                
                CustomButton(
                    action: {
                        print("Button tapped!")
                    },
                    spacing: 5,
                    text: "Pronunciation",
                    backgroundRectangle: LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.92, green: 0.97, blue: 1), location: 0.17),
                            Gradient.Stop(color: Color(red: 0.97, green: 0.66, blue: 0.21), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.49, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    ),
                    shadow: Color(red: 0, green: 0.16, blue: 0.48).opacity(0.25),
                    stroke: Color(red: 0.9, green: 0.62, blue: 0.21),
                    backgroundBox: LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.26),
                            Gradient.Stop(color: Color(red: 1, green: 0.59, blue: 0), location: 0.59),
                        ],
                        startPoint: UnitPoint(x: 0.86, y: -3.28),
                        endPoint: UnitPoint(x: 0.86, y: 4.27)
                    )
                )
                
                CustomButton(
                    action: {
                        print("Button tapped!")
                    },
                    spacing: 15,
                    text: "Blank Space",
                    backgroundRectangle: LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.17),
                            Gradient.Stop(color: Color(red: 0.28, green: 0.84, blue: 0.23), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.49, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    ),
                    shadow: Color(red: 0, green: 0.16, blue: 0.48).opacity(0.25),
                    stroke: Color(red: 0.21, green: 0.59, blue: 0.2),
                    backgroundBox: LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.30),
                            Gradient.Stop(color: Color(red: 0.12, green: 0.7, blue: 0.03), location: 0.52),
                        ],
                        startPoint: UnitPoint(x: 0.86, y: -3.28),
                        endPoint: UnitPoint(x: 0.86, y: 4.27)
                    )
                )
                
                CustomButton(
                    action: {
                        print("Button tapped!")
                    },
                    spacing: 50,
                    text: "Calendar",
                    backgroundRectangle: LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.92, green: 0.97, blue: 1), location: 0.17),
                            Gradient.Stop(color: Color(red: 0.14, green: 0.59, blue: 1), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.49, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    ),
                    shadow: Color(red: 0, green: 0.16, blue: 0.48).opacity(0.25),
                    stroke: Color(red: 0.24, green: 0.5, blue: 0.81),
                    backgroundBox: LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.29),
                            Gradient.Stop(color: Color(red: 0, green: 0.46, blue: 1), location: 0.56),
                        ],
                        startPoint: UnitPoint(x: 0.86, y: -3.28),
                        endPoint: UnitPoint(x: 0.86, y: 4.27)
                    )
                )
            }
        }
        .padding(0)
    }
}

#Preview {
    Home()
}
