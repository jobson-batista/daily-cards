//
//  Deck.swift
//  DailyCards
//
//  Created by Jobson on 27/05/25.
//

import Foundation

class Category: ModelBase {
    
    public var uuid: UUID
    public var name: String
    public var description: String
    public var cards: [Card]?
    public var imageSystemName: String
    
    public var createdAt: Date
    public var updatedAt: Date
    public var deletedAt: Date?
    
    init(name: String, cards: [Card]? = nil, description: String, imageSystemName: String) {
        self.uuid = UUID()
        self.name = name
        self.cards = cards
        self.description = description
        self.imageSystemName = imageSystemName
        self.createdAt = Date.now
        self.updatedAt = Date.now
        self.deletedAt = nil
    }
    
    public func isDeleted() -> Bool {
        return deletedAt != nil ? true : false
    }
}
