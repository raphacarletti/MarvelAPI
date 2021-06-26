import Foundation

protocol ComicDetailPresentationLogic: AnyObject {
    var view: ComicDetailDisplayLogic? { get set }

    func presentComic(response: ComicDetail.FetchComic.Response)
}

final class ComicDetailPresenter: ComicDetailPresentationLogic {
    weak var view: ComicDetailDisplayLogic?

    func presentComic(response: ComicDetail.FetchComic.Response) {
        view?.showComic(viewModel: .init(comic: response.comic))
    }
}
