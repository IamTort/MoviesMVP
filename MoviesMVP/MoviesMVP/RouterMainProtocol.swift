// RouterMainProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол базового роутера
protocol RouterMainProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}
