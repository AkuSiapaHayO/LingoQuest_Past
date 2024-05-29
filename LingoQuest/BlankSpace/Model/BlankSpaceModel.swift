//
//  BlankSpaceModel.swift
//  LingoQuest
//
//  Created by MacBook Pro on 29/05/24.
//

import Foundation

struct BlankSpaceModel: Identifiable, Decodable {
    var id: Int
    var paragraph: String
    var correctWords: [String]
    var choices: [String]
}
