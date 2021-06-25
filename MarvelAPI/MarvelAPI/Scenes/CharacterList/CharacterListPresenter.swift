import Foundation

protocol CharacterListPresentationLogic {
    var view: CharacterListDisplayLogic? { get set }

    func presentCharacterListSuccess(response: CharacterList.FetchCharacterList.Response.Success)
    func presentCharacterListError(response: CharacterList.FetchCharacterList.Response.Failure)
}

final class CharacterListPresenter: CharacterListPresentationLogic {
    weak var view: CharacterListDisplayLogic?

    func presentCharacterListSuccess(response: CharacterList.FetchCharacterList.Response.Success) {
        view?.showCharacterList(viewModel: .init(marvelCharacters: response.marvelCharacters))
    }

    func presentCharacterListError(response: CharacterList.FetchCharacterList.Response.Failure) {
        view?.showError(viewModel: .init(title: L10n.ErrorAlertController.title, description: L10n.ErrorAlertController.description))
    }
}
