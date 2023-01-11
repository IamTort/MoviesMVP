// WebViewPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана вебвью
protocol WebViewPresenterProtocol: AnyObject {
    init(view: WebViewProtocol, networkService: NetworkServiceProtocol, filmIndex: Int, router: RouterProtocol)
}
