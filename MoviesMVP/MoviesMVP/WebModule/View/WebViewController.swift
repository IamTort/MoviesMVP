// WebViewController.swift
// Copyright © RoadMap. All rights reserved.

//
//  Created by angelina on 27.10.2022.
//
import UIKit
import WebKit

/// Экран вебвью
final class WebViewController: UIViewController {
    // MARK: - Private Visual Components

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    // MARK: - Public property

    var presenter: WebViewPresenterProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(webView)
        createConstraints()
    }

    private func createConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - WKNavigationDelegate, WKUIDelegate

extension WebViewController: WKNavigationDelegate, WKUIDelegate {}

// MARK: - WebViewProtocol

extension WebViewController: WebViewProtocol {
    func showAlert(title: String, message: String) {
        showErrorAlert(title: title, message: message)
    }

    func loadWebView(url: URL) {
        webView.load(URLRequest(url: url))
    }

    func goBack() {
        dismiss(animated: true)
    }
}
