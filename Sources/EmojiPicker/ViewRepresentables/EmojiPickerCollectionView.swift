import UIKit

final class EmojiPickerCollectionView: UIView {
    
    // MARK: - Properties
    
    private let emojis: [Emoji]
    private let dataSource: EmojiPickerCollectionViewDataSource
    private let delegate: EmojiPickerCollectionViewDelegate
    private let width: CGFloat
    
    // MARK: - Subviews
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: .huge, height: .huge)
        layout.minimumLineSpacing = .small
        layout.minimumInteritemSpacing = .extraSmall
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .EmojiPicker.background
        collectionView.contentInset = .init(top: .zero, left: .small, bottom: .zero, right: .small)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.register(
            EmojiPickerCollectionViewCell.self,
            forCellWithReuseIdentifier: EmojiPickerCollectionViewCell.reuseIdentifier
        )
        return collectionView
    }()
    
    override var intrinsicContentSize: CGSize {
        .init(width: width, height: Size.scrollHeight)
    }
    
    // MARK: - Initializers
    
    init(
        with emojis: [Emoji],
        width: CGFloat,
        onEmojiAppeared: @escaping (Emoji) -> Void,
        onEmojiSelected: @escaping (Emoji) -> Void
    ) {
        self.emojis = emojis
        self.width = width
        
        dataSource = EmojiPickerCollectionViewDataSource(with: emojis, onEmojiAppeared: onEmojiAppeared)
        delegate = EmojiPickerCollectionViewDelegate(emojis: emojis, onSelectEmoji: onEmojiSelected)
        
        super.init(frame: .zero)
        
        setupView()
        addNotificationObservers()
    }

    required init?(coder: NSCoder) {
        preconditionFailure("Initializer method not supported")
    }
    
    // MARK: - Configuration
    
    private func setupView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(
            forName: .categorySelected,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            if let name = notification.userInfo?["name"] as? String {
                self?.scrollToCategory(with: name)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func scrollToCategory(with name: String) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let index = emojis.firstIndex { $0.category == name }
        guard let index else { return }
        
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}
