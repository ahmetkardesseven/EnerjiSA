//
//  Coordinator.swift
//  EnerjiSA
//
//  Created by ahmetkardesseven on 6.08.2023.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
