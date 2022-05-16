//
//  ImageDetailsViewController.swift
//  UnsplashAppMVVM
//
//  Created by Dinmukhammed Sagyntkan on 14.05.2022.
//

import UIKit

class ImageDetailsViewController: UIViewController {

    var viewModel: ImageDetailsViewModelProtocol!

    // MARK: - Private properties
    private lazy var photoView: PhotoView = {
        let photoView = PhotoView()
        photoView.imageView.contentMode = .scaleAspectFit
        return photoView
    }()

    private lazy var showImageDetailsButton = UIBarButtonItem(
        image: UIImage(systemName: "info.circle"),
        style: .plain,
        target: self,
        action: #selector(showImageDetailsAlert)
    )

    private lazy var favoriteButton = UIBarButtonItem(
        image: UIImage(systemName: "heart"),
        style: .plain,
        target: self,
        action: #selector(favoriteButtonAction)
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.rightBarButtonItems = [addToFavoritesButton, showImageDetailsButton]
        setupView()
        setupImage()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        viewModel.deleteButtonPressed()
    }
}

// MARK: - Private methods
private extension ImageDetailsViewController {
    func setupView() {
        view.addSubview(photoView)

        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupImage() {
        viewModel.getImageDataWithHighRes {
            guard let imageData = self.viewModel.imageData else { return }
            self.photoView.imageView.image = UIImage(data: imageData)
        }
    }

    @objc func favoriteButtonAction() {
        viewModel.favoriteButtonPressed()
        configureFavoriteButton()
    }

    @objc func showImageDetailsAlert() {
        let userName = viewModel.userName
        let creationDate = viewModel.creationDate
        let location = viewModel.location

        let alert = UIAlertController(
            title: "Author: \(userName)",
            message: "Created: \(String(describing: creationDate))\n Location: \(location)",
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .default)

        alert.addAction(okAction)
        present(alert, animated: true)
    }

    private func configureFavoriteButton() {
        favoriteButton.image = viewModel.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
}
