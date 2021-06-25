import Foundation

enum CharacterDetail {
    enum FetchMarvelCharacter {
        struct Request {}
        struct Response {
            let marvelCharacter: MarvelCharacter
        }
        struct ViewModel {
            let marvelCharacter: MarvelCharacter
        }
    }
    enum FetchMostExpensiveMaganize {
        struct Request {}
        enum Response {
            struct Success {
                let marvelComic: MarvelComic
            }
            struct Failure {
                let error: ComicError
            }
        }
        enum ViewModel {
            struct Success {
                let marvelComic: MarvelComic
            }
            struct Failure {
                let title: String
                let description: String
                let okButton: String
            }
        }
    }
}
