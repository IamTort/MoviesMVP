// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
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
        value: UserDefaults.standard.string(forKey: Constants.apiValueKeyName)
    )

    private let queryItemLanguage = URLQueryItem(
        name: Constants.queryItemLanguageName,
        value: Constants.queryItemLanguageValue
    )

    private var category = PurchaseEndPoint.popular

    // MARK: - Public methods

    func loadFilms(page: Int, completion: @escaping (Result<[Movies]?, Error>) -> Void) {
        loadFilms(page: page, api: category, completion: completion)
    }

    func loadFilms(page: Int, api: PurchaseEndPoint, completion: @escaping (Result<[Movies]?, Error>) -> Void) {
        category = api

        let queryItemPage = URLQueryItem(name: Constants.queryItemPageName, value: "\(page)")

        var components = URLComponents()
        components.scheme = Constants.componentScheme
        components.host = Constants.componentsHost
        components.path = api.rawValue
        components.queryItems = [queryItemKey, queryItemLanguage, queryItemPage]

        loadObject(urlComponents: components) { result in
            switch result {
            case let .success(json):
                let page = json[Constants.pagesCountKeyString].intValue
                let videos = json[Constants.resultsMoviesString].arrayValue.map { Movies(json: $0, pageCount: page) }
                completion(.success(videos))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func loadFilm(index: Int, completion: @escaping (Result<Film, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = Constants.componentScheme
        components.host = Constants.componentsHost
        components.path = Constants.componentsPath + "\(index)"
        components.queryItems = [queryItemKey, queryItemLanguage]

        loadObject(urlComponents: components) { result in
            switch result {
            case let .success(json):
                let film = Film(json: json)
                completion(.success(film))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func loadVideos(index: Int, completion: @escaping (Result<[VideoId], Error>) -> Void) {
        var components = URLComponents()
        components.scheme = Constants.componentScheme
        components.host = Constants.componentsHost
        components.path = Constants.componentsPath + "\(index)" + Constants.videos
        components.queryItems = [queryItemKey, queryItemLanguage]

        loadObject(urlComponents: components) { result in
            switch result {
            case let .success(json):
                let videos = json[Constants.resultsMoviesString].arrayValue.map { VideoId(json: $0) }
                completion(.success(videos))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func loadImage(iconUrl: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: iconUrl) else { return }
        AF.request(url).responseData { response in
            switch response.result {
            case let .success(data):
                completion(data)
            case .failure:
                break
            }
        }
    }

    // MARK: - Private methods

    private func loadObject(
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
