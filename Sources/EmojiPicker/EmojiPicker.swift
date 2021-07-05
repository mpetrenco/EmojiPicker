//
//  EmojiPicker.swift
//  EmojiPicker
//
//  Created by Mihai Petrenco on 7/4/21.
//

import SwiftUI

public struct EmojiPicker: View {
    
    public var shouldDisplay: Binding<Bool>
    
    public var onEmojiSelection: ((Emoji) -> Void)?
    
    @State private var dragOffset: CGFloat = 0.0
    
    public init(shouldDisplay: Binding<Bool>, onEmojiSelection: ((Emoji) -> Void)?) {
        self.shouldDisplay = shouldDisplay
        self.onEmojiSelection = onEmojiSelection
    }
    
    public var body: some View {
        
        ZStack(alignment: .bottom) {
            
            if shouldDisplay.wrappedValue {
                Color.black.opacity(0.2).ignoresSafeArea()
            }

            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    Color.white
                    VStack(spacing: 8.0) {
                        Spacer()
                            .frame(width: 40, height: 3)
                            .background(Color.secondarySurface)
                            .padding(.top, 16.0)
                            .cornerRadius(1.5)
                        EmojiView(onEmojiSelection: onEmojiSelection)
                    }
                }
                .frame(height: 370.0)
                .cornerRadius(16.0)
                .offset(y: geometry.size.height + geometry.safeAreaInsets.bottom - (shouldDisplay.wrappedValue ? 370 : 0))
                .offset(y: dragOffset)
                .gesture(DragGesture()
                            .onChanged({ value in
                                 
                                let offset = value.startLocation.y - value.location.y
                                
                                if offset < 0 {
                                    dragOffset = -offset
                                }
                            })
                            .onEnded({ value in
                                dragOffset = 0
                                shouldDisplay.wrappedValue = value.startLocation.y - value.location.y > -150
                            })
                )
            }
            
        }
        .animation(.easeInOut(duration: 0.1))
    }
}
