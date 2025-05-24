//
//  Coordinator.swift
//  DailyCards
//
//  Created by Jobson on 24/05/25.
//

import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    func start()
}
