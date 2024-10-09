import UIKit

final class EmojiPickerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Reuse Identifier
    
    static let reuseIdentifier = "EmojiPickerCollectionViewCell"
    
    // MARK: - Subviews
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Size.emojiSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - View Setup
    
    private func setupView() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Configurations
    
    func configure(with emoji: Emoji) {
        label.text = emoji.value
    }
}
