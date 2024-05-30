//
//  CrosswordAnswerModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//
import SwiftUI
import Combine

class CrosswordAnswerModel {
    @Published var id: UUID
    @Published var row: Int
    @Published var col: Int
    @Published var letter: String
    
    init(row: Int, col: Int, letter: String) {
        self.id = UUID()
        self.row = row
        self.col = col
        self.letter = letter
    }
}


