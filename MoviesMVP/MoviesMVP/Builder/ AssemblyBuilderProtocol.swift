//  AssemblyBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол сборщика модулей
protocol AssemblyBuilderProtocol {
    func makeMainModule(router: RouterProtocol) -> UIViewController
    func makeDetailModule(filmIndex: Int, router: RouterProtocol) -> UIViewController
    func makeWebModule(filmIndex: Int, router: RouterProtocol) -> UIViewController
}
