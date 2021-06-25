import Foundation

struct MarvelComicResponse: Codable {
    var code: Int
    var data: MarvelComicDataContainer
}

struct MarvelComicDataContainer: Codable {
    var results: [MarvelComic]
}

struct MarvelComic: Codable {
    var id: Int
    var title: String
    var comicDescription: String?
    var thumbnail: MarvelThumbnail
    var prices: [ComicPrice]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case comicDescription = "description"
        case thumbnail
        case prices
    }
}

struct ComicPrice: Codable {
    let type: String
    let price: Double
}

