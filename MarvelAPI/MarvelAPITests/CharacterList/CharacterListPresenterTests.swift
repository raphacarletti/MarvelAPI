import XCTest
@testable import MarvelAPI

final class CharacterListPresenterTests: XCTestCase {
    private let viewControllerSpy = CharacterListDisplayLogicSpy()
    private lazy var sut: CharacterListPresenter = {
        let presenter = CharacterListPresenter()
        presenter.view = viewControllerSpy
        return presenter
    }()

    func test_presentCharacterListSuccess_shouldCallShowCharacterList() {
        let marvelCharacters: [MarvelCharacter] = [.stub(), .stub()]

        sut.presentCharacterListSuccess(response: .init(marvelCharacters: marvelCharacters))

        XCTAssertTrue(viewControllerSpy.showCharacterListCalled)
        XCTAssertEqual(viewControllerSpy.showCharacterListParameter?.marvelCharacters.count, marvelCharacters.count)
    }

    func test_presentCharacterListError_shouldCallShowError() {
        sut.presentCharacterListError(response: .init())

        XCTAssertTrue(viewControllerSpy.showErrorCalled)
    }
}
