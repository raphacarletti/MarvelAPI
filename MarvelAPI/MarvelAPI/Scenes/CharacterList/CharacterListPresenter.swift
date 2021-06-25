import Foundation

protocol CharacterListPresentationLogic {
    var view: CharacterListDisplayLogic? { get set }

    func presentCharacterListSuccess(response: CharacterList.FetchCharacterList.Response.Success)
}

final class CharacterListPresenter: CharacterListPresentationLogic {
    weak var view: CharacterListDisplayLogic?

    func presentCharacterListSuccess(response: CharacterList.FetchCharacterList.Response.Success) {
        view?.showCharacterList(viewModel: .init(marvelCharacters: response.marvelCharacters))
    }
}
