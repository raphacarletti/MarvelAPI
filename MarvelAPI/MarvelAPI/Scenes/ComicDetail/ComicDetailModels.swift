import Foundation

enum ComicDetail {
    enum FetchComic {
        struct Request {}
        struct Response {
            let comic: MarvelComic
        }
        struct ViewModel {
            let comic: MarvelComic
        }
    }
}
