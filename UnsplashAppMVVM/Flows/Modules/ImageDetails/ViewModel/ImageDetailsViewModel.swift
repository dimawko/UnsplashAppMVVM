//
//  ImageDetailsViewModel.swift
//  UnsplashAppMVVM
//
//  Created by Dinmukhammed Sagyntkan on 14.05.2022.
//

//class Image: Object, Codable {
//    @Persisted(primaryKey: true) var id = ""
//    @Persisted var createdAt: String? = ""
//    @Persisted var urls: Urls? = nil
//    @Persisted var likes = 0
//    @Persisted var user: User? = nil
//    @Persisted var location: Location? = nil
//    @Persisted var downloads: Int? = 0
//
//    enum CodingKeys: String, CodingKey {
//        case createdAt = "created_at"
//        case id, urls, likes, user, location, downloads
//    }
//}
//
//class Urls: Object, Codable {
//    @Persisted var regular = ""
//    @Persisted var small = ""
//}
//
//class User: Object, Codable {
//    @Persisted var name = ""
//}
//
//class Location: Object, Codable {
//    @Persisted var title: String? = nil
//}

import Foundation
import RealmSwift

protocol ImageDetailsViewModelProtocol {
    var userName: String { get }
    var creationDate: String { get }
    var location: String { get }
    var downloads: Int { get }
    var imageData: Data? { get }
    var viewModelDidChange: ((ImageDetailsViewModelProtocol) -> Void)? { get set }
    var isFavorite: Bool { get }
    init(image: Image)
    func getImageDataWithHighRes(completion: @escaping() -> Void)
    func favoriteButtonPressed()
}

class ImageDetailsViewModel: ImageDetailsViewModelProtocol {

    var userName: String {
        guard let userName = image.user?.name else { return "Unknown" }
        return userName
    }

    var creationDate: String {
        guard let creationDate = image.createdAt else { return "Unknown" }
        return creationDate
    }

    var location: String {
        guard let location = image.location?.title else { return "Unknown"}
        return location
    }

    var downloads: Int {
        image.downloads
    }

    var imageData: Data?

    var isFavorite: Bool {
        get {
            StorageManager.shared.save(image)
        } set {
            StorageManager.shared.delete(image)
            viewModelDidChange?(self)
        }
    }

    var viewModelDidChange: ((ImageDetailsViewModelProtocol) -> Void)?

    private let image: Image

    required init(image: Image) {
        self.image = image
    }

    func getImageDataWithHighRes(completion: @escaping() -> Void) {
        NetworkManager.shared.fetchImage(imageResolution: .regular, imageData: image) { result in
            switch result {
            case .success(let imageData):
                self.imageData = imageData
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    func favoriteButtonPressed() {
        isFavorite.toggle()
    }

    private func isImageFavorite() -> Bool {
        var isFavorite = false
        let realmImage = StorageManager.shared.realm?.object(ofType: Image.self, forPrimaryKey: image.id)
        if realmImage != nil {
            isFavorite = true
        }
        return isFavorite
    }
}
