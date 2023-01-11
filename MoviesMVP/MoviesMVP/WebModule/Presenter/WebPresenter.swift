// WebPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Презентер
final class WebPresenter: WebViewPresenterProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let urlShemeHostPath = "https://www.themoviedb.org/movie/"
        static let urlFragment = "#play="
        static let alertTitleString = "Ошибка"
        static let alertMessageString = "Ошибка на сервере"
    }

    // MARK: - Private property

    private weak var view: WebViewProtocol?
    private let networkService: NetworkServiceProtocol?
    private var router: RouterProtocol?

    // MARK: - Initializer

    required init(
        view: WebViewProtocol,
        networkService: NetworkServiceProtocol,
        filmIndex: Int,
        router: RouterProtocol
    ) {
        self.view = view
        self.networkService = networkService
        self.router = router
        loadWebViewData(index: filmIndex)
    }

    // MARK: - Private methods

    private func loadWebViewData(index: Int) {
        networkService?.loadVideos(index: index) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(videos):
                guard let key = videos.first?.key,
                      let url =
                      URL(string: "\(Constants.urlShemeHostPath)\(index)\(Constants.urlFragment)\(key)")
                else {
                    self.view?.goBack()
                    return
                }
                self.view?.loadWebView(url: url)
            case .failure:
                self.view?.showAlert(title: Constants.alertTitleString, message: Constants.alertMessageString)
            }
        }
    }
}
