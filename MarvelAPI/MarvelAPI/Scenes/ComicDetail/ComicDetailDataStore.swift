import Foundation

protocol ComicDetailDataStoreProtocol {
    var comic: MarvelComic { get }
}

final class ComicDetailDataStore: ComicDetailDataStoreProtocol {
    var comic: MarvelComic

    init(comic: MarvelComic) {
        self.comic = comic
    }
}
