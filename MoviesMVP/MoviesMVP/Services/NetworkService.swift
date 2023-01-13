// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import KeychainAccess
import SwiftyJSON

/// Типы запросов
enum PurchaseEndPoint: String {
    case link = "https://image.tmdb.org/t/p/w500"
    case popular = "/3/movie/popular"
    case topRated = "/3/movie/top_rated"
    case upcoming = "/3/movie/upcoming"
}

/// Класс, отвечающий за загрузку данных с сервера
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let queryItemKeyName = "api_key"
        static let apiValueKeyName = "apiKey"
        static let queryItemLanguageName = "language"
        static let queryItemLanguageValue = "ru-Ru"
        static let queryItemPageName = "page"
        static let componentScheme = "https"
        static let componentsHost = "api.themoviedb.org"
        static let componentsPath = "/3/movie/"
        static let videos = "/videos"
        static let pagesCountKeyString = "total_pages"
        static let resultsMoviesString = "results"
    }

    // MARK: - Private property

    private let queryItemKey = URLQueryItem(
        name: Constants.queryItemKeyName,
        value: KeychainService.shared.getAPIKey()
    )

    private let queryItemLanguage = URLQueryItem(
        name: Constants.queryItemLanguageName,
        value: Constants.queryItemLanguageValue
    )

    private var category = PurchaseEndPoint.popular

    // MARK: - Public methods

    func fetchMovies(page: Int, completion: @escaping (Result<[Movie]?, Error>) -> Void) {
        fetchMovies(page: page, api: category, completion: completion)
    }

    func fetchMovies(page: Int, api: PurchaseEndPoint, completion: @escaping (Result<[Movie]?, Error>) -> Void) {
        category = api

        let queryItemPage = URLQueryItem(name: Constants.queryItemPageName, value: "\(page)")

        var components = URLComponents()
        components.scheme = Constants.componentScheme
        components.host = Constants.componentsHost
        components.path = api.rawValue
        components.queryItems = [queryItemKey, queryItemLanguage, queryItemPage]

        loadJSON(urlComponents: components) { result in
            switch result {
            case let .success(json):
                let page = json[Constants.pagesCountKeyString].intValue
                let videos = json[Constants.resultsMoviesString].arrayValue.map { Movie(json: $0, pageCount: page) }
                completion(.success(videos))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchMovie(index: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = Constants.componentScheme
        components.host = Constants.componentsHost
        components.path = "\(Constants.componentsPath)\(index)"
        components.queryItems = [queryItemKey, queryItemLanguage]

        loadJSON(urlComponents: components) { result in
            switch result {
            case let .success(json):
                let film = MovieDetail(json: json)
                completion(.success(film))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchVideos(index: Int, completion: @escaping (Result<[VideoId], Error>) -> Void) {
        var components = URLComponents()
        components.scheme = Constants.componentScheme
        components.host = Constants.componentsHost
        components.path = "\(Constants.componentsPath)\(index)\(Constants.videos)"
        components.queryItems = [queryItemKey, queryItemLanguage]

        loadJSON(urlComponents: components) { result in
            switch result {
            case let .success(json):
                let videos = json[Constants.resultsMoviesString].arrayValue.map { VideoId(json: $0) }
                completion(.success(videos))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private methods

    private func loadJSON(
        urlComponents: URLComponents,
        completion: @escaping (Result<JSON, Error>) -> Void
    ) {
        guard let url = urlComponents.url else { return }
        AF.request(url).responseData { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                completion(.success(json))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
