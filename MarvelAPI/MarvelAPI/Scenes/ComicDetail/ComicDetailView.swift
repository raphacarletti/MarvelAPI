import UIKit
import Cartography

protocol ComicDetailViewProtocol: AnyObject {
    func set(comic: MarvelComic)
}

final class ComicDetailView: UIView, ComicDetailViewProtocol {
    private var scrollView = UIScrollView()
    private var contentView = UIView()

    private var comicAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private var nameHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.ComicDetail.nameHeader
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
        label.text = L10n.ComicDetail.descriptionHeader
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

    private var priceHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.ComicDetail.priceHeader
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private var isExpanded = false

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
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

        contentView.addSubview(comicAvatarImageView)
        constrain(contentView, comicAvatarImageView) { superView, imageView in
            imageView.leading == superView.leading
            imageView.trailing == superView.trailing
            imageView.topMargin == superView.topMargin + 20
            imageView.height == 200
        }

        stackView.addArrangedSubview(nameHeaderLabel)
        stackView.addArrangedSubview(nameLabel)

        contentView.addSubview(stackView)
        constrain(contentView, comicAvatarImageView, stackView) { superView, imageView, stackView in
            stackView.top == imageView.bottom + 16
            stackView.leading == superView.leading + 16
            stackView.trailing == superView.trailing - 16
            stackView.bottom <= superView.bottomMargin - 16
        }
    }

    func set(comic: MarvelComic) {
        nameLabel.text = comic.title

        if let description = comic.comicDescription {
            stackView.addArrangedSubview(descriptionHeaderLabel)
            stackView.addArrangedSubview(descriptionLabel)
            descriptionLabel.text = description
        }

        if let price = comic.prices.first {
            stackView.addArrangedSubview(priceHeaderLabel)
            stackView.addArrangedSubview(priceLabel)
            priceLabel.text = "$\(price.price)"
        }

        let url = URL(string: comic.thumbnail.urlString)
        comicAvatarImageView.kf.indicatorType = .activity
        comicAvatarImageView.kf.setImage(with: url, placeholder: Asset.placeholder.image)
    }

    @objc
    func didTapDecriptionLabel() {
        isExpanded.toggle()
        descriptionLabel.numberOfLines = isExpanded ? 0 : 3
    }
}
