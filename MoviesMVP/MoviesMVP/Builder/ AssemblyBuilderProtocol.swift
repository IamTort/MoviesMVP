//  AssemblyBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол строителя
protocol AssemblyBuilderProtocol {
    func makeMainModule(router: RouterProtocol) -> UIViewController
    func makeDetailModule(filmIndex: Int, router: RouterProtocol) -> UIViewController
    func makeWebModule(filmIndex: Int, router: RouterProtocol) -> UIViewController
}
