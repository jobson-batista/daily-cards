//
//  Card.swift
//  DailyCards
//
//  Created by Jobson on 24/05/25.
//

import Foundation

class Card {
    
    var question: String
    var answer: String
    var deleted: Bool
    var category: String
    
    init(question: String, answer: String, category: String) {
        self.question = question
        self.answer = answer
        self.category = category
        self.deleted = false
    }
    
}
