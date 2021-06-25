import UIKit

protocol CharacterDetailRoutingLogic {
    var viewController: UIViewController? { get set }

    func goToComicDetail(with comic: MarvelComic)
}

final class CharacterDetailRouter: CharacterDetailRoutingLogic {
    weak var viewController: UIViewController?

    func goToComicDetail(with comic: MarvelComic) {

    }
}
