//
//  Coordinator.swift
//  Turmys App
//
//  Created by Yerkezhan Zheneessova on 31.03.2025.
//

import Foundation

/// Base protocol for all coordinators.
/// AppCoordinator is the single coordinator managing the entire navigation flow.
protocol Coordinator: AnyObject {
    func start()
}
