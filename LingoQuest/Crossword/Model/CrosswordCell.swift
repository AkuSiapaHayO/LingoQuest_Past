//
//  CrosswordCell.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//
import SwiftUI

class CrosswordCell: Identifiable, ObservableObject {
    let id: Int
    @Published var letter: String
    let isEditable: Bool
    let label: String?
    
    init(id: Int, letter: String = "", isEditable: Bool, label: String? = nil) {
        self.id = id
        self.letter = letter
        self.isEditable = isEditable
        self.label = label
    }
}
