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
                    .frame(width: 211, height: 43, alignment: .top)
                
                Text("LingoQuest")
                    .font(
                        Font.custom("Poppins", size: 40)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .frame(width: 241, height: 55, alignment: .top)
            }
            
            VStack(spacing: 15) {
                CustomButton(
                    action: {
                        // Goto page
                    },
                    spacing: 40,
                    rectangleSize: 30,
                    text: "Crossword",
                    size: 24,
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
                    paddingStart: 40,
                    paddingEnd: 80,
                    backgroundBox: LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.27),
                            Gradient.Stop(color: Color(red: 1, green: 0, blue: 0), location: 0.59),
                        ],
                        startPoint: UnitPoint(x: 0.86, y: -3.28),
                        endPoint: UnitPoint(x: 0.86, y: 4.27)
                    ),
                    topBottomPadding: 20
                )
                
                CustomButton(
                    action: {
                        // Goto page
                    },
                    spacing: 30,
                    rectangleSize: 30,
                    text: "Pronunciation",
                    size: 24,
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
                    paddingStart: 40,
                    paddingEnd: 60,
                    backgroundBox: LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.26),
                            Gradient.Stop(color: Color(red: 1, green: 0.59, blue: 0), location: 0.59),
                        ],
                        startPoint: UnitPoint(x: 0.86, y: -3.28),
                        endPoint: UnitPoint(x: 0.86, y: 4.27)
                    ),
                    topBottomPadding: 20
                )
                
                CustomButton(
                    action: {
                        // Goto page
                    },
                    spacing: 40,
                    rectangleSize: 30,
                    text: "Blank Space",
                    size: 24,
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
                    paddingStart: 40,
                    paddingEnd: 60,
                    backgroundBox: LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.30),
                            Gradient.Stop(color: Color(red: 0.12, green: 0.7, blue: 0.03), location: 0.52),
                        ],
                        startPoint: UnitPoint(x: 0.86, y: -3.28),
                        endPoint: UnitPoint(x: 0.86, y: 4.27)
                    ),
                    topBottomPadding: 20
                )
                
                CustomButton(
                    action: {
                        // Goto page
                    },
                    spacing: 53,
                    rectangleSize: 30,
                    text: "Calendar",
                    size: 24,
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
                    paddingStart: 40,
                    paddingEnd: 80,
                    backgroundBox: LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white, location: 0.29),
                            Gradient.Stop(color: Color(red: 0, green: 0.46, blue: 1), location: 0.56),
                        ],
                        startPoint: UnitPoint(x: 0.86, y: -3.28),
                        endPoint: UnitPoint(x: 0.86, y: 4.27)
                    ),
                    topBottomPadding: 20
                )
            }
        }
        .padding(0)
    }
}

#Preview {
    Home()
}
