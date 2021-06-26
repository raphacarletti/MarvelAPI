import XCTest
@testable import MarvelAPI

final class CharacterListRouterTests: XCTestCase {
    private lazy var viewControllerSpy = ViewControllerSpy()
    private lazy var navigationControllerSpy = NavigationControllerSpy(rootViewController: viewControllerSpy)
    private lazy var sut: CharacterListRouter = {
        let sut = CharacterListRouter()
        sut.viewController = viewControllerSpy
        return sut
    }()

    func test_goToCharacterDetail_shouldPushCharacterDetailScreen() {
        sut.goToCharacterDetail(with: .stub())

        XCTAssertTrue(navigationControllerSpy.pushViewControllerCalled)
    }

    func test_showErrorAlert_shouldPresentAlert() {
        sut.showErrorAlert(title: "", message: "", okAction: "")

        XCTAssertTrue(viewControllerSpy.presentCalled)
    }
}
