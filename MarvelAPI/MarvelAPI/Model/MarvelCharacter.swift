import UIKit
import Foundation

struct MarvelResponse: Codable {
    var code: Int
    var data: MarvelCharacterDataContainer
}

struct MarvelCharacterDataContainer: Codable {
    var offset: Int
    var limit: Int
    var count: Int
    var results: [MarvelCharacter]
}

struct MarvelCharacter: Codable {
    var id: Int
    var name: String
    var heroDescription: String
    var thumbnail: MarvelThumbnail

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case heroDescription = "description"
        case thumbnail
    }
}

struct MarvelThumbnail: Codable {
    var path: String
    var imageExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }

    var urlString: String {
        return "\(path).\(imageExtension)"
    }

}
