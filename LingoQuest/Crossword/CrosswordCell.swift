//
//  CrosswordCell.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//

import Foundation
import SwiftUI

class CrosswordCell: Identifiable, ObservableObject {
    let id: Int
    @Published var letter: String
    let isEditable: Bool
    
    init(id: Int, letter: String = "", isEditable: Bool) {
        self.id = id
        self.letter = letter
        self.isEditable = isEditable
    }
}
