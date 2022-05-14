//
//  Image.swift
//  UnsplashAppMVVM
//
//  Created by Dinmukhammed Sagyntkan on 13.05.2022.
//

import Foundation
import RealmSwift

// swiftlint:disable redundant_optional_initialization
struct SearchResults: Codable {
    let results: [Image]
}

class Image: Object, Codable {
    @Persisted(primaryKey: true) var id = ""
    @Persisted var createdAt: String? = ""
    @Persisted var urls: Urls? = nil
    @Persisted var likes = 0
    @Persisted var user: User? = nil
    @Persisted var location: Location? = nil
    @Persisted var downloads = 0

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id, urls, likes, user, location, downloads
    }
}

class Urls: Object, Codable {
    @Persisted var regular = ""
    @Persisted var small = ""
}

class User: Object, Codable {
    @Persisted var name = ""
}

class Location: Object, Codable {
    @Persisted var title: String? = nil
}
