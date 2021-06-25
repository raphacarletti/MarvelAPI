import Foundation

protocol CharacterDetailPresentationLogic: AnyObject {
    var view: CharacterDetailDisplayLogic? { get set }

    func presentMarvelCharacter(response: CharacterDetail.FetchMarvelCharacter.Response)
    func presentMostExpensiveComicSuccess(response: CharacterDetail.FetchMostExpensiveMaganize.Response.Success)
    func presentMostExpensiveComicFailure(response: CharacterDetail.FetchMostExpensiveMaganize.Response.Failure)
}

final class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    weak var view: CharacterDetailDisplayLogic?

    func presentMarvelCharacter(response: CharacterDetail.FetchMarvelCharacter.Response) {
        view?.showMarvelCharacter(viewModel: .init(marvelCharacter: response.marvelCharacter))
    }

    func presentMostExpensiveComicSuccess(response: CharacterDetail.FetchMostExpensiveMaganize.Response.Success) {
        view?.showComic(viewModel: .init(marvelComic: response.marvelComic))
    }

    func presentMostExpensiveComicFailure(response: CharacterDetail.FetchMostExpensiveMaganize.Response.Failure) {
        switch response.error {
        case .network:
            view?.showError(viewModel: .init(title: L10n.ErrorAlertController.title, description: L10n.ErrorAlertController.description, okButton: L10n.ErrorAlertController.okAction))
        case .notFound:
            view?.showError(viewModel: .init(title: L10n.NoComicAlertController.title, description: L10n.NoComicAlertController.description, okButton: L10n.NoComicAlertController.okAction))
        }
    }
}
