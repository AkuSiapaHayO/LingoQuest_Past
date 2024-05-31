//
//  Home.swift
//  LingoQuest_Mac
//
//  Created by Dhiaz Ramadhan on 31/05/24.
//

import SwiftUI

struct Home: View {
    @StateObject private var streakController = StreakController()
    
    var body: some View {
        VStack(alignment: .center, spacing: 60) {
            VStack {
                Text("Welcome To")
                    .font(
                        Font.custom("Poppins", size: 70)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .frame(width: 553, height: 96, alignment: .top)
                
                Text("LingoQuest")
                    .font(
                        Font.custom("Poppins", size: 100)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .frame(width: 630, height: 136, alignment: .top)
            }
            
            VStack(spacing: 30) {
                CustomButton(
                    action: {
                        // Goto page
                    },
                    spacing: 120,
                    rectangleSize: 45,
                    text: "Crossword",
                    size: 45,
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
                    paddingStart: 60,
                    paddingEnd: 180,
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
                    spacing: 100,
                    rectangleSize: 45,
                    text: "Pronunciation",
                    size: 45,
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
                    paddingStart: 60,
                    paddingEnd: 140,
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
                    spacing: 100,
                    rectangleSize: 45,
                    text: "Blank Space",
                    size: 45,
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
                    paddingStart: 60,
                    paddingEnd: 160,
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
                    spacing: 120,
                    rectangleSize: 45,
                    text: "Calendar",
                    size: 45,
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
                    paddingStart: 60,
                    paddingEnd: 210,
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
                
                Text("Day Streak: \(streakController.currentStreak)")
                    .font(.largeTitle)
                    .padding()
            }
            .onAppear {
                streakController.resetDailyFlags()
            }
        }
        .padding(0)
    }
}

#Preview {
    Home()
}
