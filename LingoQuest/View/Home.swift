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
                Button(action: {
                    // Action
                    print("Button tapped!")
                }) {
                    HStack(spacing: 40) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 30, height: 30)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.92, green: 0.97, blue: 1), location: 0.17),
                                        Gradient.Stop(color: Color(red: 1, green: 0.14, blue: 0.14), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.49, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                )
                            )
                            .cornerRadius(10)
                            .shadow(color: Color(red: 0, green: 0.16, blue: 0.48).opacity(0.25), radius: 5, x: 0, y: 0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .inset(by: 2)
                                    .stroke(Color(red: 0.81, green: 0.24, blue: 0.24), lineWidth: 4)
                            )
                        
                        Text("Crossword")
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
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: .white, location: 0.27),
                                Gradient.Stop(color: Color(red: 1, green: 0, blue: 0), location: 0.59),
                            ],
                            startPoint: UnitPoint(x: 0.86, y: -3.28),
                            endPoint: UnitPoint(x: 0.86, y: 4.27)
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 90))
                }
                
                Button(action: {
                    // Action
                    print("Button tapped!")
                }) {
                    HStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 30, height: 30)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.92, green: 0.97, blue: 1), location: 0.17),
                                        Gradient.Stop(color: Color(red: 0.97, green: 0.66, blue: 0.21), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.49, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                )
                            )
                            .cornerRadius(10)
                            .shadow(color: Color(red: 0, green: 0.16, blue: 0.48).opacity(0.25), radius: 5, x: 0, y: 0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .inset(by: 2)
                                    .stroke(Color(red: 0.9, green: 0.62, blue: 0.21), lineWidth: 4)
                            )
                        
                        Text("Pronunciation")
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
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: .white, location: 0.26),
                                Gradient.Stop(color: Color(red: 1, green: 0.59, blue: 0), location: 0.59),
                            ],
                            startPoint: UnitPoint(x: 0.86, y: -3.28),
                            endPoint: UnitPoint(x: 0.86, y: 4.27)
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 90))
                }
                
                Button(action: {
                    // Action
                    print("Button tapped!")
                }) {
                    HStack(spacing: 15) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 30, height: 30)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: .white, location: 0.17),
                                        Gradient.Stop(color: Color(red: 0.28, green: 0.84, blue: 0.23), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.49, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                )
                            )
                            .cornerRadius(10)
                            .shadow(color: Color(red: 0, green: 0.16, blue: 0.48).opacity(0.25), radius: 5, x: 0, y: 0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .inset(by: 2)
                                    .stroke(Color(red: 0.21, green: 0.59, blue: 0.2), lineWidth: 4)
                            )
                        
                        Text("Blank Space")
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
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: .white, location: 0.30),
                                Gradient.Stop(color: Color(red: 0.12, green: 0.7, blue: 0.03), location: 0.52),
                            ],
                            startPoint: UnitPoint(x: 0.86, y: -3.28),
                            endPoint: UnitPoint(x: 0.86, y: 4.27)
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 90))
                }
                
                Button(action: {
                    // Action
                    print("Button tapped!")
                }) {
                    HStack(spacing: 50) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 30, height: 30)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.92, green: 0.97, blue: 1), location: 0.17),
                                        Gradient.Stop(color: Color(red: 0.14, green: 0.59, blue: 1), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.49, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                )
                            )
                            .cornerRadius(10)
                            .shadow(color: Color(red: 0, green: 0.16, blue: 0.48).opacity(0.25), radius: 5, x: 0, y: 0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .inset(by: 2)
                                    .stroke(Color(red: 0.24, green: 0.5, blue: 0.81), lineWidth: 4)
                            )
                        
                        Text("Calendar")
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
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: .white, location: 0.29),
                                Gradient.Stop(color: Color(red: 0, green: 0.46, blue: 1), location: 0.56),
                            ],
                            startPoint: UnitPoint(x: 0.86, y: -3.28),
                            endPoint: UnitPoint(x: 0.86, y: 4.27)
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 90))
                }
            }
        }
        .padding(0)
    }
}

#Preview {
    Home()
}
