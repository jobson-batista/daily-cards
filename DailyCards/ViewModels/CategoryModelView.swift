//
//  DeckModelView.swift
//  DailyCards
//
//  Created by Jobson on 27/05/25.
//

import Foundation

class CategoryModelView {
    
    static let shared = CategoryModelView()
    
    private var categories: [Category] = [
        Category(name: "English", cards: [], description: "Basic words and phrases", imageSystemName: "globe"),
        Category(name: "Java Studies", cards: [], description: "Basic java sintax", imageSystemName: "cup.and.heat.waves.fill"),
        Category(name: "Swift and UIKit", cards: [], description: "Studies of iOS Development", imageSystemName: "swift"),
    ]
    
    private init() {}
    
    func fetchData()  -> [Category] {
        return self.categories
    }
    
    func addCategory(category: Category) {
        categories.append(category)
    }
    
}
