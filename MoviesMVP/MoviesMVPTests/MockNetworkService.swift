// MockNetworkService.swift
// Copyright © RoadMap. All rights reserved.

//
//  MockNetworkService.swift
//  MoviesMVPTests
//
//  Created by angelina on 16.01.2023.
//
@testable import MoviesMVP
import SwiftyJSON
import XCTest

// Mок для нетворк сервиса
final class MockNetworkService: NetworkServiceProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let jsonFileName = "MockMovie"
        static let totalPagesString = "total_pages"
        static let resultsString = "results"
        static let jsonString = "json"
        static let errorBundleString = "Bundle file not found"
        static let errorString = "error"
    }

    // MARK: - Public methods

    func fetchMovies(page: Int, completion: @escaping (Result<[Movie]?, Error>) -> Void) {}

    func fetchMovies(page: Int, api: PurchaseEndPoint, completion: @escaping (Result<[Movie]?, Error>) -> Void) {
        let json = getData(name: Constants.jsonFileName)
        let page = json[Constants.totalPagesString].intValue
        let movies = json[Constants.resultsString].arrayValue.map { Movie(json: $0, pageCount: page) }
        completion(.success(movies))
    }

    func fetchMovie(index: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {}

    func fetchVideos(index: Int, completion: @escaping (Result<[VideoId], Error>) -> Void) {}

    // MARK: - Private methods

    private func getData(name: String, withExtension: String = Constants.jsonString) -> JSON {
        guard let fileURL = Bundle(for: MoviesMVPTests.MockNetworkService.self)
            .url(forResource: name, withExtension: withExtension)
        else { fatalError(Constants.errorBundleString) }
        do {
            let data = try Data(contentsOf: fileURL)
            let json = try JSON(data: data)
            return json
        } catch {
            print(Constants.errorString)
        }
        return JSON()
    }
}
