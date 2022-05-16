//
//  FavoriteImagesViewModel.swift
//  UnsplashAppMVVM
//
//  Created by Dinmukhammed Sagyntkan on 14.05.2022.
//

import Foundation
import RealmSwift

protocol FavoriteImagesViewModelProtocol {
    var favoriteImages: Results<Image>? { get }
    func numberOfRows() -> Int
    func getCellViewModel(for indexPath: IndexPath) -> FavoriteImageCellViewModelProtocol?
    func fetchFavoriteImages(completion: @escaping() -> Void)
}

class FavoriteImagesViewModel: FavoriteImagesViewModelProtocol {

    var favoriteImages: Results<Image>?

    func numberOfRows() -> Int {
        favoriteImages?.count ?? 0
    }

    func getCellViewModel(for indexPath: IndexPath) -> FavoriteImageCellViewModelProtocol? {
        guard let favoriteImage = favoriteImages?[indexPath.row] else { return nil }
        return FavoriteImageCellViewModel(image: favoriteImage)
    }

    func fetchFavoriteImages(completion: @escaping () -> Void) {
        favoriteImages = (StorageManager.shared.realm?.objects(Image.self))
        completion()
    }
}
