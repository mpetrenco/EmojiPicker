import SwiftUI

struct EmojiPickerView: View {

    // MARK: - Properties
    
    private let isDisplayed: Binding<Bool>
    private let categories = EmojiRepository.shared.categories
    private let emojis = EmojiRepository.shared.emojis
    private let onEmojiSelected: (Emoji) -> Void
    
    // MARK: - Observables
    
    @State private var dragOffset = 0.0
    @State private var sectionTitle = ""
    
    // MARK: - Initializers
    
    init(
        isDisplayed: Binding<Bool>,
        onEmojiSelected: @escaping (Emoji) -> Void
    ) {
        self.isDisplayed = isDisplayed
        self.onEmojiSelected = onEmojiSelected
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundOverlay
            contentView
        }
        .animation(
            .easeIn(duration: Size.animationDuration),
            value: isDisplayed.wrappedValue
        )
        .ignoresSafeArea()
    }
}

extension EmojiPickerView {
    
    private var backgroundOverlay: some View {
        Color.black.ignoresSafeArea()
            .opacity(isDisplayed.wrappedValue ? Size.backgroundOpacity : 0.0)
            .onTapGesture {
                isDisplayed.wrappedValue.toggle()
            }
    }

    private var disclosureIndicatorView: some View {
        RoundedRectangle(cornerRadius: .extraSmall)
            .frame(width: .extraLarge, height: .extraSmall)
            .foregroundStyle(.EmojiPicker.highlight)
    }
        
    private var sectionTitleText: some View {
        Text(sectionTitle.uppercased())
            .font(.EmojiPicker.caption)
            .foregroundStyle(.EmojiPicker.secondary)
            .padding(.bottom, .medium)
    }
        
    private var sectionSelectionView: some View {
        HStack(spacing: .zero) {
            ForEach(categories) { category in
                Spacer()
                sectionButton(category: category)
            }
            Spacer()
        }
    }
    
    private func sectionButton(category: EmojiCategory) -> some View {
        Button(
            action: {
                NotificationCenter.default.post(
                    name: .categorySelected,
                    object: nil,
                    userInfo: ["name": category.title]
                )
            },
            label: {
                Image(category.iconName, bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .medium, height: .medium)
                    .foregroundColor(
                        category.title == sectionTitle
                        ? .EmojiPicker.primary
                        : .EmojiPicker.secondary
                    )
                    .padding(.small)
                    .background(
                        category.title == sectionTitle
                        ? .EmojiPicker.highlight
                        : .EmojiPicker.background
                    )
                    .clipShape(Circle())
            }
        )
    }
    
    private func emojiGrid(with width: CGFloat) -> some View {
        EmojiPickerGridView(
            with: emojis,
            width: width,
            onEmojiAppeared: { emoji in
                sectionTitle = emoji.category
            },
            onEmojiSelected: { emoji in
                onEmojiSelected(emoji)
                isDisplayed.wrappedValue.toggle()
            }
        )
        .padding(.bottom, .medium)
    }
    
    private var contentView: some View {
        GeometryReader { proxy in
            VStack(spacing: .small) {
                disclosureIndicatorView
                sectionTitleText
                emojiGrid(with: proxy.size.width)
                sectionSelectionView
            }
        }
        .padding(.top, .small)
        .padding(.bottom, .extraLarge)
        .frame(height: Size.contentHeight)
        .background(.EmojiPicker.background)
        .clipShape(RoundedRectangle(cornerRadius: Size.contentCornerRadius))
        .offset(y: isDisplayed.wrappedValue ? dragOffset : Size.contentHeight)
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = max(0, value.translation.height)
                }
                .onEnded { value in
                    if value.translation.height > 0 {
                        isDisplayed.wrappedValue.toggle()
                        dragOffset = 0
                    }
                }
        )
    }
}
