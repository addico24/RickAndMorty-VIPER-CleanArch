//
//  DetailViewController.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol!
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .fill
        return sv
    }()
    
    private let characterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private let genderLabel = UILabel()
    private let originLabel = UILabel()
    private let locationLabel = UILabel()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.hidesWhenStopped = true
        return ai
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Detail"
        
        nameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        
        statusLabel.font = .systemFont(ofSize: 18, weight: .medium)
        statusLabel.textAlignment = .center
        
        [genderLabel, originLabel, locationLabel].forEach {
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = .black
        }
        
        view.addSubview(activityIndicator)
        view.addSubview(characterImageView)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(genderLabel)
        stackView.addArrangedSubview(originLabel)
        stackView.addArrangedSubview(locationLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

// MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func showLoading() {
        activityIndicator.startAnimating()
        stackView.isHidden = true
        characterImageView.isHidden = true
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        stackView.isHidden = false
        characterImageView.isHidden = false
    }
    
    func updateView(with data: DetailViewData) {
        nameLabel.text = data.title
        
        statusLabel.text = data.statusText
        statusLabel.textColor = data.statusColor
        
        genderLabel.text = data.genderText
        originLabel.text = data.originText
        locationLabel.text = data.locationText
        
        characterImageView.loadImage(from: data.imageURL)
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
