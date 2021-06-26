import XCTest
@testable import MarvelAPI

final class CharacterListWorkerTests: XCTestCase {
    private let serviceStub = ServiceStub()
    private lazy var sut: CharacterListWorker = CharacterListWorker(service: serviceStub)

    func test_fetchCharacterList_whenFail_shouldReturnError() {
        sut.fetchCharacterList { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(_):
                XCTFail("should have an error")
            }
        }

        XCTAssertTrue(serviceStub.requestCodableCalled)
        XCTAssertEqual(serviceStub.requestCodableParameter is MarvelRequest, true)
    }

    func test_fetchCharacterList_whenSuccess_shouldReturnMarvelCharacters_and_sum20ToOffset() {
        let marvelCharacter: [MarvelCharacter] = [.stub(), .stub(), .stub()]
        let marvelCharacterResponse = MarvelCharacterResponse(code: 200, data: .init(offset: 0, limit: 20, count: 20, results: marvelCharacter))
        serviceStub.requestCodableReturnSuccess = marvelCharacterResponse

        sut.fetchCharacterList { result in
            switch result {
            case .failure(_):
                XCTFail("should have success")
            case .success(let characters):
                XCTAssertEqual(marvelCharacter.count, characters.count)
            }
        }

        XCTAssertTrue(serviceStub.requestCodableCalled)
        XCTAssertEqual(serviceStub.requestCodableParameter is MarvelRequest, true)

        let mirror = Mirror(reflecting: sut)
        let offset = mirror.firstChild(of: Int.self)
        XCTAssertEqual(offset, ServiceConstants.responseLimit)
    }
}
