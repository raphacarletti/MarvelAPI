import UIKit

protocol CharacterListRoutingLogic {
    var viewController: UIViewController? { get set }

    func goToCharacterDetail(with marvelCharacter: MarvelCharacter)
}

final class CharacterListRouter: CharacterListRoutingLogic {
    weak var viewController: UIViewController?

    func goToCharacterDetail(with marvelCharacter: MarvelCharacter) {
        let characterDetail = CharacterDetailConfigurator().instantiateView(marvelCharacter: marvelCharacter)
        viewController?.navigationController?.pushViewController(characterDetail, animated: true)
    }
}
