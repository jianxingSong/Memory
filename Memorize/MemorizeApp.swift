//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 宋健星 on 2024/11/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            @StateObject var game = EmojiMemoryGame()
            
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
