import UIKit
@testable import MarvelAPI

final class CharacterListBusinessLogicSpy: CharacterListBusinessLogic {
    private(set) var fetchCharacterListCalled = false
    private(set) var fetchCharacterListParametersPassed: CharacterList.FetchCharacterList.Request?
    func fetchCharacterList(request: CharacterList.FetchCharacterList.Request) {
        fetchCharacterListCalled = true
        fetchCharacterListParametersPassed = request
    }
}

final class CharacterListRoutingLogicSpy: CharacterListRoutingLogic {
    var viewController: UIViewController? = nil

    private(set) var goToCharacterDetailCalled = false
    private(set) var goToCharacterDetailParametersPassed: MarvelCharacter?
    func goToCharacterDetail(with marvelCharacter: MarvelCharacter) {
        goToCharacterDetailCalled = true
        goToCharacterDetailParametersPassed = marvelCharacter
    }

    private(set) var showErrorAlertDetailCalled = false
    private(set) var showErrorAlertParametersPassed: (title: String, message: String, okAction: String)?
    func showErrorAlert(title: String, message: String, okAction: String) {
        showErrorAlertDetailCalled = true
        showErrorAlertParametersPassed = (title, message, okAction)
    }
}

final class CharacterListDataStoreSpy: CharacterListDataStoreProtocol {
    var marvelCharacters: [MarvelCharacter] = []
    var isLoadingMore: Bool = false
}

final class CharacterListViewSpy: UIView, CharacterListViewProtocol {
    var dataSourceDelegate: (UITableViewDataSource & UITableViewDelegate)?

    private(set) var addRowsCalled = false
    private(set) var addRowsParameterPassed: Int?
    func addRows(numberOfRows: Int) {
        addRowsCalled = true
        addRowsParameterPassed = numberOfRows
    }

    private(set) var addLoadingFooterCalled = false
    func addLoadingFooter() {
        addLoadingFooterCalled = true
    }

    private(set) var removeLoadingFooterCalled = false
    func removeLoadingFooter() {
        removeLoadingFooterCalled = true
    }

    private(set) var showLoadingScreenCalled = false
    func showLoadingScreen() {
        showLoadingScreenCalled = true
    }

    private(set) var dismissLoadingScreenCalled = false
    func dismissLoadingScreen() {
        dismissLoadingScreenCalled = true
    }
}

extension MarvelCharacter {
    static func stub(id: Int = 0, name: String = "Iron Man", heroDescription: String = "", thumbnail: MarvelThumbnail = .stub()) -> MarvelCharacter {
        return MarvelCharacter(id: id, name: name, heroDescription: heroDescription, thumbnail: thumbnail)
    }
}

extension MarvelThumbnail {
    static func stub(path: String = "http://google.com/image", imageExtension: String = "jpg") -> MarvelThumbnail {
        return MarvelThumbnail(path: path, imageExtension: imageExtension)
    }
}

final class CharacterListPresenterSpy: CharacterListPresentationLogic {
    var view: CharacterListDisplayLogic?

    private(set) var presentCharacterListSuccessCalled = false
    private(set) var presentCharacterListSuccessParameter: CharacterList.FetchCharacterList.Response.Success?
    func presentCharacterListSuccess(response: CharacterList.FetchCharacterList.Response.Success) {
        presentCharacterListSuccessCalled = true
        presentCharacterListSuccessParameter = response
    }

    private(set) var presentCharacterListErrorCalled = false
    private(set) var presentCharacterListErrorParameter: CharacterList.FetchCharacterList.Response.Failure?
    func presentCharacterListError(response: CharacterList.FetchCharacterList.Response.Failure) {
        presentCharacterListErrorCalled = true
        presentCharacterListErrorParameter = response
    }
}

final class CharacterListWorkerStub: CharacterListWorkerProtocol {
    var fetchCharacterListShouldReturn: Result<[MarvelCharacter], Error>?
    private(set) var fetchCharacterListCalled = false
    func fetchCharacterList(completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        guard let result = fetchCharacterListShouldReturn else {
            return
        }
        fetchCharacterListCalled = true
        completion(result)
    }
}

final class CharacterListDisplayLogicSpy: CharacterListDisplayLogic {
    private(set) var showCharacterListCalled = false
    private(set) var showCharacterListParameter: CharacterList.FetchCharacterList.ViewModel.Success?
    func showCharacterList(viewModel: CharacterList.FetchCharacterList.ViewModel.Success) {
        showCharacterListCalled = true
        showCharacterListParameter = viewModel
    }

    private(set) var showErrorCalled = false
    private(set) var showErrorParameter: CharacterList.FetchCharacterList.ViewModel.Failure?
    func showError(viewModel: CharacterList.FetchCharacterList.ViewModel.Failure) {
        showErrorCalled = true
        showErrorParameter = viewModel
    }
}


