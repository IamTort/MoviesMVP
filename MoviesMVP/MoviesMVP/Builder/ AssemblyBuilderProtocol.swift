//  AssemblyBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол строителя
protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(filmIndex: Int, router: RouterProtocol) -> UIViewController
    func createWebModule(filmIndex: Int, router: RouterProtocol) -> UIViewController
}
