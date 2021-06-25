import UIKit
import Cartography

final class LoadingView: UIView {
    private var effectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: effect)
        return view
    }()

    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    private func setup() {
        backgroundColor = .clear

        effectView.contentView.addSubview(activityIndicator)
        constrain(effectView.contentView, activityIndicator) { superView, indicator in
            indicator.center == superView.center
        }

        addSubview(effectView)
        constrain(self, effectView) { superView, effectView in
            effectView.edges == superView.edges
        }
    }
}
