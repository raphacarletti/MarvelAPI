import UIKit

final class ViewControllerSpy: UIViewController {
    private(set) var presentCalled = false
    private(set) var presentParameter: UIViewController?
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCalled = true
        presentParameter = viewControllerToPresent
    }
}

final class NavigationControllerSpy: UINavigationController {
    private(set) var pushViewControllerCalled = false
    private(set) var pushViewControllerParameter: UIViewController?
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        pushViewControllerParameter = viewController
    }
}
