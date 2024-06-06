//
//  ContentView.swift
//  LingoQuest
//
//  Created by MacBook Pro on 24/05/24.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        CrosswordView(levelNumber: 6,levelsViewModel: CrosswordLevelsViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

