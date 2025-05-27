//
//  ModelBase.swift
//  DailyCards
//
//  Created by Jobson on 27/05/25.
//

import Foundation

protocol ModelBase {
    
    var createdAt: Date { get }
    var updatedAt: Date { get }
    var deletedAt: Date? { get }
}
