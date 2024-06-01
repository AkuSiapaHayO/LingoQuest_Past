//
//  CrosswordAnswerModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 30/05/24.
//

import Foundation

struct CrosswordAnswerModel: Codable, Identifiable {
    let id: Int
    let row: Int
    let col: Int
    let letter: String
}
