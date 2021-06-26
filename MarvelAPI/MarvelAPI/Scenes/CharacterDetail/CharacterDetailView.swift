import UIKit
import Cartography

protocol CharacterDetailViewProtocol: AnyObject {
    func set(marvelCharacter: MarvelCharacter)
    func set(delegate: CharacterDetailViewDelegate)
    func stopLoading()
}

protocol CharacterDetailViewDelegate: AnyObject {
    func didTapMostExpensiveMaganize()
}

final class CharacterDetailView: UIView, CharacterDetailViewProtocol {
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var characterAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private var nameHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.CharacterDetail.nameHeader
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()

    private var descriptionHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.CharacterDetail.descriptionHeader
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 3
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDecriptionLabel)))
        return label
    }()

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var mostExpensiveMagazineButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapMostExpensiveMagazineButton), for: .touchUpInside)
        button.setTitle(L10n.CharacterDetail.mostExpensiveMagazine, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()

    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private var isExpanded = false
    private weak var delegate: CharacterDetailViewDelegate?

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    func set(delegate: CharacterDetailViewDelegate) {
        self.delegate = delegate
    }

    func setup() {
        backgroundColor = .white

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        constrain(self, scrollView, contentView) { superView, scrollView, contentView in
            scrollView.edges == superView.edges
            contentView.edges == scrollView.edges
            contentView.width == scrollView.width
        }

        contentView.addSubview(characterAvatarImageView)
        constrain(contentView, characterAvatarImageView) { superView, imageView in
            imageView.leading == superView.leading
            imageView.trailing == superView.trailing
            imageView.topMargin == superView.topMargin + 20
            imageView.height == 200
        }

        stackView.addArrangedSubview(nameHeaderLabel)
        stackView.addArrangedSubview(nameLabel)

        contentView.addSubview(stackView)
        constrain(contentView, characterAvatarImageView, stackView) { superView, imageView, stackView in
            stackView.top == imageView.bottom + 16
            stackView.leading == superView.leading + 16
            stackView.trailing == superView.trailing - 16
        }

        contentView.addSubview(mostExpensiveMagazineButton)
        constrain(contentView, stackView, mostExpensiveMagazineButton) { superView, stackView, button in
            button.top == stackView.bottom + 16
            button.centerX == superView.centerX
            button.width == 240
            button.height == 40
        }

        contentView.addSubview(activityIndicator)
        constrain(contentView, mostExpensiveMagazineButton, activityIndicator) { superView, button, indicator in
            indicator.top == button.bottom + 16
            indicator.centerX == superView.centerX
            indicator.bottomMargin <= superView.bottomMargin - 8
        }
    }

    func set(marvelCharacter: MarvelCharacter) {
        nameLabel.text = marvelCharacter.name

        if !marvelCharacter.heroDescription.isEmpty {
            stackView.addArrangedSubview(descriptionHeaderLabel)
            stackView.addArrangedSubview(descriptionLabel)
            descriptionLabel.text = marvelCharacter.heroDescription
        }

        let url = URL(string: marvelCharacter.thumbnail.urlString)
        characterAvatarImageView.kf.indicatorType = .activity
        characterAvatarImageView.kf.setImage(with: url, placeholder: Asset.placeholder.image)
    }

    @objc
    func didTapDecriptionLabel() {
        isExpanded.toggle()
        descriptionLabel.numberOfLines = isExpanded ? 0 : 3
    }

    @objc
    func didTapMostExpensiveMagazineButton() {
        activityIndicator.startAnimating()
        delegate?.didTapMostExpensiveMaganize()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }
}
