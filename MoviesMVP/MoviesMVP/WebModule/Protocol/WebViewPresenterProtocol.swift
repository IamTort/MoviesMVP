// WebViewPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

//  WebViewPresenterProtocol.swift
//  MoviesMVP
//  Created by angelina on 11.01.2023.
import Foundation

/// Протокол презентера экрана вебвью
protocol WebViewPresenterProtocol: AnyObject {
    init(view: WebViewProtocol, networkService: NetworkServiceProtocol, filmIndex: Int, router: RouterProtocol)
}
