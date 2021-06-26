import XCTest
@testable import MarvelAPI

class CharacterListInteractorTests: XCTestCase {
    private let presenterSpy = CharacterListPresenterSpy()
    private let workerStub = CharacterListWorkerStub()
    private lazy var sut: CharacterListInteractor = {
        return CharacterListInteractor(presenter: presenterSpy, worker: workerStub)
    }()

    func test_fetchCharacterList_whenGetError_shouldCallPresentError() {
        workerStub.fetchCharacterListShouldReturn = .failure(NSError())

        sut.fetchCharacterList(request: .init())

        XCTAssertTrue(presenterSpy.presentCharacterListErrorCalled)
        XCTAssertTrue(workerStub.fetchCharacterListCalled)
    }

    func test_fetchCharacterList_whenGetSuccess_shouldCallPresentError() {
        let marvelCharacters: [MarvelCharacter] = [.stub(), .stub()]
        workerStub.fetchCharacterListShouldReturn = .success(marvelCharacters)

        sut.fetchCharacterList(request: .init())

        XCTAssertTrue(presenterSpy.presentCharacterListSuccessCalled)
        XCTAssertEqual(presenterSpy.presentCharacterListSuccessParameter?.marvelCharacters.count, marvelCharacters.count)
        XCTAssertTrue(workerStub.fetchCharacterListCalled)
    }

}
