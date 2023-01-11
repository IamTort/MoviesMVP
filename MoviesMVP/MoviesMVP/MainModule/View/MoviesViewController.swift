// MoviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Контроллер экрана Фильмы
final class MoviesViewController: UIViewController {
    // MARK: - Private Enum

    private enum Constants {
        static let popular = "Популярное"
        static let topRated = "Топ"
        static let upcoming = "Скоро"
        static let cellIdentifier = "cell"
        static let chevronLeftImageName = "chevron.left"
        static let chevronRightImageName = "chevron.right"
        static let movies = "Фильмы"
        static let selectedSegmentIndex = 0
        static let alertTitleString = "Ошибка"
        static let alertMessageString = "Данные не получены"
        static let heightRow = 240
        static let offsetIndex = 0
    }

    // MARK: - Private Visual Components

    private lazy var segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: items)
        segment.tintColor = UIColor.black
        segment.selectedSegmentIndex = Constants.selectedSegmentIndex
        segment.selectedSegmentTintColor = .systemGray2
        segment.addTarget(self, action: #selector(updateTableViewAction), for: .allEvents)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        return tableView
    }()

    // MARK: - Public property

    var presenter: MainViewPresenterProtocol?

    // MARK: - Private property

    private let items = [Constants.popular, Constants.topRated, Constants.upcoming]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Public method

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset

        guard deltaOffset <= CGFloat(Constants.offsetIndex) else { return }
        presenter?.fetchNextMovies()
    }

    // MARK: - Private methods

    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = Constants.movies
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(segmentedControl)
        createConstraint()
    }

    private func createConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),

            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func updateTableViewAction() {
        presenter?.updateMoviesCategory(sender: segmentedControl.selectedSegmentIndex)
    }
}

// MARK: - UITableViewDataSource

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? FilmTableViewCell {
            guard let film = presenter?.movies?[indexPath.row],
                  let networkService = presenter?.networkService else { return UITableViewCell() }
            cell.setupData(data: film, networkService: networkService)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(Constants.heightRow)
    }
}

// MARK: - UITableViewDelegate

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let filmIndex = presenter?.movies?[indexPath.row].id else { return }
        presenter?.tapOnFilm(filmId: filmIndex)
    }
}

// MARK: - MainViewProtocol

extension MoviesViewController: MainViewProtocol {
    func scrollToTop() {
        tableView.setContentOffset(.zero, animated: true)
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    func failure(error: Error) {
        showErrorAlert(title: Constants.alertTitleString, message: Constants.alertMessageString)
    }
}
