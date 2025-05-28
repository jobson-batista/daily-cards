//
//  Card.swift
//  DailyCards
//
//  Created by Jobson on 24/05/25.
//

import Foundation

class Card: ModelBase {
    
    var uuid: UUID
    var question: String
    var answer: String
    var category: Category
    
    var createdAt: Date
    var updatedAt: Date
    var deletedAt: Date?
    
    init(question: String, answer: String, category: Category) {
        self.uuid = UUID()
        self.question = question
        self.answer = answer
        self.category = category
        self.createdAt = Date.now
        self.updatedAt = Date.now
        self.deletedAt = nil
    }
    
    public func isDeleted() -> Bool {
        if self.deletedAt != nil {
            return true
        }
        return false
    }
    
}
