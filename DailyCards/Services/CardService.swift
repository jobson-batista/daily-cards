//
//  CardService.swift
//  DailyCards
//
//  Created by Jobson on 24/05/25.
//

class CardService {
    
    // Singleton
    static let shared = CardService()
    private let data: [Card] = [
        Card(question: "O que é Java?", answer: "É uma linguagem de programação.", category: "Programação"),
        Card(question: "Traduza: What about you?", answer: "E você?", category: "Inglês"),
        Card(question: "Traduza: Jam", answer: "Geléia", category: "Inglês")
    ]
    
    private init() {}
    
    func fetchData()  -> [Card] {
        return self.data
    }
    
    func getCategories() -> [String] {
        var categories: [String] = []
        
        for card in data {
            if !categories.contains(card.category) {
                categories.append(card.category)
            }
        }
        
        return categories
    }
    
}
