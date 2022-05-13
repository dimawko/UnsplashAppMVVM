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
}

class ImageCollectionCellViewModel: ImageCollectionCellViewModelProtocol {


    var imageData: Data?

    func getImageData() {
        NetworkManager.shared.fetchImage(imageType: .small, imageData: image) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self.imageData = imageData
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
