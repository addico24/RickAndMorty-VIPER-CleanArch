//
//  HomeViewController.swift
//  VIPER
//
//  Created by rico on 3.01.2026.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController{
    var presenter: HomePresenterProtocol!
    
    private var items: [CharacterViewItem] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .systemGreen
        return indicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        title = "Rick & Morty"
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .lightGray
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func showLoading() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
    func updateView(with characterItems: [CharacterViewItem]) {
        self.items = characterItems
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: -
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        let item = items[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item.name
        content.secondaryText = item.statusText
        content.secondaryTextProperties.color = item.statusColor
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelect(at: indexPath.row)
    }
}
