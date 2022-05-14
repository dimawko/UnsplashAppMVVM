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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
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

        viewModel.getImageDataWithHighRes {
            guard let imageData = self.viewModel.imageData else { return }
            self.photoView.imageView.image = UIImage(data: imageData)
        }
    }
}
