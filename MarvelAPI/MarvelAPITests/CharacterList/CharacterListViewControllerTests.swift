import XCTest
@testable import MarvelAPI

class CharacterListViewControllerTests: XCTestCase {
    private let interactorSpy = CharacterListBusinessLogicSpy()
    private let routerSpy = CharacterListRoutingLogicSpy()
    private let dataStoreSpy = CharacterListDataStoreSpy()
    private let viewSpy = CharacterListViewSpy()
    private lazy var sut: CharacterListViewController = {
        return CharacterListViewController(interactor: interactorSpy, router: routerSpy, dataStore: dataStoreSpy, customView: viewSpy)
    }()

    func test_viewDidLoad_whenCalled_shouldShowLoading_and_fetchCharacters() {
        sut.viewDidLoad()

        XCTAssertTrue(viewSpy.showLoadingScreenCalled)
        XCTAssertTrue(interactorSpy.fetchCharacterListCalled)
    }

    func test_shouldLoadMore_whenIndexPathIsNotTheLast_and_isNotLoading_shouldNotFetchMore_and_shouldNotAddLoadingFooter() {
        dataStoreSpy.isLoadingMore = false
        dataStoreSpy.marvelCharacters = [.stub(), .stub(), .stub()]

        sut.shouldLoadMore(indexPath: IndexPath(row: 0, section: 0))

        XCTAssertFalse(interactorSpy.fetchCharacterListCalled)
        XCTAssertFalse(viewSpy.addLoadingFooterCalled)
    }

    func test_shouldLoadMore_whenIndexPathIsTheLast_and_isLoading_shouldNotFetchMore_and_shouldNotAddLoadingFooter() {
        dataStoreSpy.isLoadingMore = true
        dataStoreSpy.marvelCharacters = [.stub(), .stub(), .stub()]

        sut.shouldLoadMore(indexPath: IndexPath(row: 2, section: 0))

        XCTAssertFalse(interactorSpy.fetchCharacterListCalled)
        XCTAssertFalse(viewSpy.addLoadingFooterCalled)
    }

    func test_shouldLoadMore_whenIndexPathIsNotTheLast_and_isLoading_shouldNotFetchMore_and_shouldNotAddLoadingFooter() {
        dataStoreSpy.isLoadingMore = true
        dataStoreSpy.marvelCharacters = [.stub(), .stub(), .stub()]

        sut.shouldLoadMore(indexPath: IndexPath(row: 0, section: 0))

        XCTAssertFalse(interactorSpy.fetchCharacterListCalled)
        XCTAssertFalse(viewSpy.addLoadingFooterCalled)
    }

    func test_shouldLoadMore_whenIndexPathIsTheLast_and_isNotLoading_shouldFetchMore_and_shouldAddLoadingFooter() {
        dataStoreSpy.isLoadingMore = false
        dataStoreSpy.marvelCharacters = [.stub(), .stub(), .stub()]

        sut.shouldLoadMore(indexPath: IndexPath(row: 2, section: 0))

        XCTAssertTrue(interactorSpy.fetchCharacterListCalled)
        XCTAssertTrue(viewSpy.addLoadingFooterCalled)
    }

    func test_stopLoading_shouldSetIsLoadingMoreToFalse_callDismissLoadingScreen_and_removeLoadingFooter() {
        dataStoreSpy.isLoadingMore = true

        sut.stopLoading()

        XCTAssertFalse(dataStoreSpy.isLoadingMore)
        XCTAssertTrue(viewSpy.removeLoadingFooterCalled)
        XCTAssertTrue(viewSpy.dismissLoadingScreenCalled)
    }

    func test_showCharacterList_shouldAppendCharacters_stopLoading_and_addRows() {
        dataStoreSpy.isLoadingMore = true
        dataStoreSpy.marvelCharacters = []

        sut.showCharacterList(viewModel: .init(marvelCharacters: [.stub(), .stub()]))

        XCTAssertFalse(dataStoreSpy.isLoadingMore)
        XCTAssertTrue(viewSpy.removeLoadingFooterCalled)
        XCTAssertTrue(viewSpy.dismissLoadingScreenCalled)
        XCTAssertEqual(dataStoreSpy.marvelCharacters.count, 2)
        XCTAssertTrue(viewSpy.addRowsCalled)
        XCTAssertEqual(viewSpy.addRowsParameterPassed, 2)
    }

    func test_showError_shouldStopLoading_and_callShowErrorRouter() {
        dataStoreSpy.isLoadingMore = true

        sut.showError(viewModel: .init(title: "title", description: "description", okButton: "okButton"))

        XCTAssertFalse(dataStoreSpy.isLoadingMore)
        XCTAssertTrue(viewSpy.removeLoadingFooterCalled)
        XCTAssertTrue(viewSpy.dismissLoadingScreenCalled)
        XCTAssertTrue(routerSpy.showErrorAlertDetailCalled)
        XCTAssertEqual(routerSpy.showErrorAlertParametersPassed?.title, "title")
        XCTAssertEqual(routerSpy.showErrorAlertParametersPassed?.message, "description")
        XCTAssertEqual(routerSpy.showErrorAlertParametersPassed?.okAction, "okButton")
    }

    func test_didSelectedRow_shouldGoToCharacterDetailScreen() {
        let marvelCharacter = MarvelCharacter.stub()
        dataStoreSpy.marvelCharacters = [marvelCharacter]

        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))

        XCTAssertTrue(routerSpy.goToCharacterDetailCalled)
        XCTAssertEqual(routerSpy.goToCharacterDetailParametersPassed?.name, marvelCharacter.name)
    }
    
}
