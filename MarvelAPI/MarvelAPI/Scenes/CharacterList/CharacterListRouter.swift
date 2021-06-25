import UIKit

protocol CharacterListRoutingLogic {
    var viewController: UIViewController? { get set }
}

final class CharacterListRouter: CharacterListRoutingLogic {
    weak var viewController: UIViewController?
}
