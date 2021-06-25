import Foundation

protocol CharacterListDataStoreProtocol {
    var marvelCharacters: [MarvelCharacter] { get set }
    var isLoadingMore: Bool { get set }
}

final class CharacterListDataStore: CharacterListDataStoreProtocol {
    var marvelCharacters: [MarvelCharacter] = []
    var isLoadingMore: Bool = false
}
