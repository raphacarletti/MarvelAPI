import Foundation

enum CharacterList {
    enum FetchCharacterList {
        struct Request {}
        enum Response {
            struct Success {
                let marvelCharacters: [MarvelCharacter]
            }
            struct Failure {

            }
        }
        enum ViewModel {
            struct Success {
                let marvelCharacters: [MarvelCharacter]
            }
            struct Failure {

            }
        }
    }
}
