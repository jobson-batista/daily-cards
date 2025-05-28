//
//  CardService.swift
//  DailyCards
//
//  Created by Jobson on 24/05/25.
//

class CardModelView {
    
    // Singleton
    static let shared = CardModelView()
    
    private let cards: [Card] = [
        Card(question: "O que é Java?", answer: "É uma linguagem de programação.", category: CategoryModelView.shared.fetchData()[1]),
        Card(question: "O que é Swift?", answer: "É uma linguagem de programação.", category: CategoryModelView.shared.fetchData()[2]),
        Card(question: "Traduza: What about you?", answer: "E você?", category: CategoryModelView.shared.fetchData()[0]),
        Card(question: "Traduza: Jam", answer: "Geléia", category: CategoryModelView.shared.fetchData()[0])
    ]
    
    private init() {}
    
    func fetchData()  -> [Card] {
        return self.cards
    }
    
    func getCategories() -> [Category] {
        var categories: [Category] = []
        
        for card in cards {
            categories.append(card.category)
        }
        
        return categories
    }
    
}
