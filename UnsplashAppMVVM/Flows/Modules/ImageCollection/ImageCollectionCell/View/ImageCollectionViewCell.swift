//
//  ImageCollectionViewCell.swift
//  UnsplashAppMVVM
//
//  Created by Dinmukhammed Sagyntkan on 13.05.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    static let identifier = "ImageCollectionViewCell"

    var photoView: PhotoView = {
        let view = PhotoView()
        view.imageView.contentMode = .scaleAspectFill
        return view
    }()

    var viewModel: ImageCollectionCellViewModelProtocol! {
        didSet {
            photoView.spinner.startAnimating()
            viewModel.getImageData {
                guard let imageData = self.viewModel.imageData else { return }
                self.photoView.imageView.image = UIImage(data: imageData)
                self.photoView.spinner.stopAnimating()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.imageView.image = nil
    }

    private func setupCell() {
        addSubview(photoView)

        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoView.topAnchor.constraint(equalTo: topAnchor),
            photoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
