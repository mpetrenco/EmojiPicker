//
//  EmojiPicker.swift
//
//  Created by Mihai Petrenco on 7/4/21.
//

import SwiftUI

private struct Constants {
    static let pickerSize: CGFloat = 370.0;
    static let backgroundOpacity: Double = 0.2;
    static let verticalSpacing: CGFloat = 8.0;
    static let pickerCornerRadius: CGFloat = 16.0;
    static let topPadding: CGFloat = 16.0;
}

public struct EmojiPicker: View {
    
    /**
     * The boolean binding which toggles the Emoji Picker on/off.
     */
    public var shouldDisplay: Binding<Bool>
    
    /**
     * A callback which is executed once an emoji has been selected from the list.
     */
    public var onEmojiSelection: ((Emoji) -> Void)?
    
    /**
     * A private state property for handling the drag behavior.
     */
    @State private var dragOffset: CGFloat = 0.0
    
    /**
     * The public initializer for this class.
     *
     * - Parameter shouldDisplay: boolean binding which toggles the Emoji Picker on/off.
     * - Parameter onEmojiSelection: callback which is executed once an emoji has been selected from the list.
     */
    public init(shouldDisplay: Binding<Bool>,
                onEmojiSelection: ((Emoji) -> Void)?) {
        
        self.shouldDisplay = shouldDisplay
        self.onEmojiSelection = onEmojiSelection
    }
    
    /**
     * The main rendering body/.
     */
    public var body: some View {
        
        ZStack(alignment: .bottom) {
            
            if shouldDisplay.wrappedValue {
                Color.black.opacity(Constants.backgroundOpacity).ignoresSafeArea()
            }
            
            GeometryReader { geometry in
                
                ZStack(alignment: .top) {
                    
                    Color.white
                    
                    VStack(spacing: Constants.verticalSpacing) {
                        
                        EmojiDragIndicator()
                            .padding(.top, Constants.topPadding)
                        
                        EmojiView(onEmojiSelection: onEmojiSelection)
                    }
                }
                .frame(height: Constants.pickerSize)
                .cornerRadius(Constants.pickerCornerRadius)
                .offset(y: getDrawerPosition(for: geometry))
                .offset(y: dragOffset)
                .gesture(DragGesture()
                            .onChanged(onDragChange)
                            .onEnded(onDragEnded)
                )
            }
            
        }
        .animation(.easeInOut(duration: 0.1))
    }
    
    /**
     * A method for determining the drawer position for its displayed/hidden states.
     * This is the initial position of the drawer once it appears or after it hides.
     */
    private func getDrawerPosition(for proxy: GeometryProxy) -> CGFloat {
        let drawerOffset = (shouldDisplay.wrappedValue ? Constants.pickerSize : 0)
        return proxy.size.height + proxy.safeAreaInsets.bottom - drawerOffset
    }
    
    /**
     * A method for determining the drawer's offset change, as a result of drag gestures.
     */
    private func onDragChange(value: DragGesture.Value) {
        if value.startLocation.y - value.location.y < 0 {
            dragOffset = -(value.startLocation.y - value.location.y)
        }
    }
    
    /**
     * A method for determining the final drawer value, based ot its final drag position.
     * If the drag position is more than half of its size, the drawer should dismiss.
     */
    private func onDragEnded(value: DragGesture.Value) {
        dragOffset = 0
        shouldDisplay.wrappedValue = value.startLocation.y - value.location.y > -(Constants.pickerSize / 2)
    }
}
