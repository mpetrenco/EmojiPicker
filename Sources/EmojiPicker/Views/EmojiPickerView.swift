import SwiftUI

struct EmojiPickerView: View {
    
    // MARK: - Constants
    
    enum Constant {
        static let backgroundOpacity = 0.05
        static let animationDuration = 0.2
        static let contentHeight = 390.0
        static let scrollHeight = 230.0
        static let emojiSize = 40.0
        static let contentCornerRadius = 16.0
    }
    
    // MARK: - Properties
    
    private let isDisplayed: Binding<Bool>
    private let onEmojiSelected: (Emoji) -> Void
    private let categories = EmojiRepository.shared.categories
    private let emojis = EmojiRepository.shared.emojis
    
    // MARK: - Observables
    
    @State private var dragOffset = 0.0
    @State private var currentCategory: EmojiCategory?
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
            .easeIn(duration: Constant.animationDuration),
            value: isDisplayed.wrappedValue
        )
        .ignoresSafeArea()
    }
}

extension EmojiPickerView {
    
    private var backgroundOverlay: some View {
        Color.black.ignoresSafeArea()
            .opacity(isDisplayed.wrappedValue ? Constant.backgroundOpacity : 0.0)
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
    
    private var gridRows: [GridItem] {
        Array(repeating: GridItem(.fixed(Constant.emojiSize)), count: 5)
    }
    
    private var emojiGridView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridRows, spacing: .medium) {
                ForEach(emojis) { emoji in
                    Button(emoji.value) {
                        onEmojiSelected(emoji)
                        isDisplayed.wrappedValue.toggle()
                    }
                    .font(.EmojiPicker.heading)
                    .id(emoji)
                    .onAppear {
                        sectionTitle = emoji.category
                    }
                }
            }
            .padding(.horizontal, .medium)
        }
        .frame(height: Constant.scrollHeight)
        .padding(.bottom, .medium)
    }
    
    private func sectionSelectionView(proxy: ScrollViewProxy) -> some View {
        HStack(spacing: .zero) {
            ForEach(categories) { category in
                Spacer()
                sectionButton(category: category, proxy: proxy)
            }
            Spacer()
        }
    }
    
    private func sectionButton(category: EmojiCategory, proxy: ScrollViewProxy) -> some View {
        Button(
            action: {
                withAnimation {
                    proxy.scrollTo(category.emojis.first, anchor: .leading)
                }
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
    
    private var contentView: some View {
        VStack(spacing: .small) {
            disclosureIndicatorView
            sectionTitleText
            ScrollViewReader { proxy in
                VStack(spacing: .small) {
                    emojiGridView
                    sectionSelectionView(proxy: proxy)
                }
            }
        }
        .padding(.top, .small)
        .padding(.bottom, .extraLarge)
        .frame(height: Constant.contentHeight)
        .background(.EmojiPicker.background)
        .offset(y: isDisplayed.wrappedValue ? dragOffset : Constant.contentHeight)
        .clipShape(RoundedRectangle(cornerRadius: Constant.contentCornerRadius))
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
