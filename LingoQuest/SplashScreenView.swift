//
//  SplashScreenView.swift
//  LingoQuest
//
//  Created by student on 16/05/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive: Bool = false
    @State var isAnimating = false
    var body: some View {
        ZStack {
            Color.white
            if self.isActive{
                ContentView()
            } else{
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    
                    Text("Interactive Language Learning App")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 30))
                        .multilineTextAlignment(.center)
                        .opacity(isAnimating ? 2.0 : 0.0)
                        .animation(.easeIn(duration: 1.0), value: isAnimating)
                        .onAppear {
                            isAnimating = true
                        }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
