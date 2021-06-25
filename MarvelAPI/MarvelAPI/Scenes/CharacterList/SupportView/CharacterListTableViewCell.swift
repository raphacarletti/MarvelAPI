import UIKit
import Cartography
import Kingfisher

class CharacterListTableViewCell: UITableViewCell {
    private var characterAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 34
        return imageView
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        characterAvatarImageView.kf.cancelDownloadTask()
    }

    private func setup() {
        contentView.addSubview(characterAvatarImageView)
        constrain(contentView, characterAvatarImageView) { superView, imageView in
            imageView.leading == superView.leading + 8
            imageView.top >= superView.top + 8
            imageView.bottom <= superView.bottom - 8
            imageView.centerY == superView.centerY
            imageView.width == 68
            imageView.height == imageView.width
        }

        contentView.addSubview(nameLabel)
        constrain(contentView, characterAvatarImageView, nameLabel) { superView, imageView, label in
            label.leading == imageView.trailing + 8
            label.centerY == imageView.centerY
            label.trailing <= superView.trailing - 4
        }
    }

    func set(marvelCharacter: MarvelCharacter) {
        nameLabel.text = marvelCharacter.name

        let url = URL(string: marvelCharacter.thumbnail.urlString)
        characterAvatarImageView.kf.indicatorType = .activity
        characterAvatarImageView.kf.setImage(with: url, placeholder: Asset.placeholder.image)
    }

}
