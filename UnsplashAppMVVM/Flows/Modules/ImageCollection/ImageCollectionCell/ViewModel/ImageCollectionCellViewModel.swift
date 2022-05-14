//
//  ImageCollectionCellViewModel.swift
//  UnsplashAppMVVM
//
//  Created by Dinmukhammed Sagyntkan on 13.05.2022.
//

import Foundation

protocol ImageCollectionCellViewModelProtocol {
    var imageData: Data? { get }
    init(image: Image)
    func getImageData(completion: @escaping() -> Void)
}

class ImageCollectionCellViewModel: ImageCollectionCellViewModelProtocol {

    var imageData: Data?

    func getImageData(completion: @escaping() -> Void) {
        NetworkManager.shared.fetchImage(imageType: .small, imageData: image) { [weak self] result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.imageData = imageData
                    completion()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private let image: Image

    required init(image: Image) {
        self.image = image
    }
}
