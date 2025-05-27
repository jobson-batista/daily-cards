//
//  AppCoordinator.swift
//  DailyCards
//
//  Created by Jobson on 24/05/25.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //let homeViewController: CardViewController = CardViewController()
        let homeViewController: HomeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
}
