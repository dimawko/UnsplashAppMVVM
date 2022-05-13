//
//  imagesCollectionViewModel.swift
//  UnsplashAppMVVM
//
//  Created by Dinmukhammed Sagyntkan on 13.05.2022.
//

import Foundation

protocol ImageCollectionViewModelProtocol {
    var images: [Image] { get }
    func fetchImages(completion: @escaping() -> Void)
    func numberOfItems() -> Int
    func getCellViewModel(at indexPath: IndexPath) -> ImageCollectionCellViewModelProtocol
}

class ImageCollectionViewModel: ImageCollectionViewModelProtocol {

    var images: [Image] = []

    func fetchImages(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchImageData(
            dataType: [Image].self,
            url: LinkString.randomPhoto,
            query: "count=30"
        ) { [unowned self] result in
            switch result {
            case .success(let imagesData):
                self.images = imagesData
                print(self.images)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    func numberOfItems() -> Int {
        images.count
    }

    func getCellViewModel(at indexPath: IndexPath) -> ImageCollectionCellViewModelProtocol {
        let image = images[indexPath.row]
        return ImageCollectionCellViewModel(image: image)
    }
}
