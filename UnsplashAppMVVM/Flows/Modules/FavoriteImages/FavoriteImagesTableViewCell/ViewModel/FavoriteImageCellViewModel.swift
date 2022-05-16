//
//  FavoriteImageCellViewModel.swift
//  UnsplashAppMVVM
//
//  Created by Dinmukhammed Sagyntkan on 14.05.2022.
//

import Foundation

protocol FavoriteImageCellViewModelProtocol {
    var userName: String? { get }
    var imageData: Data? { get }
    init(image: Image)
    func getImageData(completion: @escaping() -> Void)
}

class FavoriteImageCellViewModel: FavoriteImageCellViewModelProtocol {

    var userName: String? {
        guard let user = favoriteImage.user else { return nil }
        return user.name
    }

    var imageData: Data?

    private let favoriteImage: Image

    required init(image: Image) {
        self.favoriteImage = image
    }

    func getImageData(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchImage(imageResolution: .small, imageData: favoriteImage) { result in
            switch result {
            case .success(let data):
                self.imageData = data
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}
