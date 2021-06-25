import Foundation

protocol CharacterDetailDataStoreProtocol {
    var marvelCharacter: MarvelCharacter { get }
}

final class CharacterDetailDataStore: CharacterDetailDataStoreProtocol {
    var marvelCharacter: MarvelCharacter

    init(marvelCharacter: MarvelCharacter) {
        self.marvelCharacter = marvelCharacter
    }
}
