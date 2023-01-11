// WebViewProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана Вебвью
protocol WebViewProtocol: AnyObject {
    func goBack()
    func loadWebView(url: URL)
    func showAlert(title: String, message: String)
}
