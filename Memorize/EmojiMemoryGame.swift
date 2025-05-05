//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by 宋健星 on 2025/4/26.
//

import SwiftUI

// MVVM中的view model，由于view model可能会被很多view持有，所以经济的方式是使用类（依靠引用传递）
class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻", "😈", "🎃", "🕷️", "💀", "❄️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"]
    
    // swift中通常无法推断返回类型
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairOfCard: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    // 为了分离view 和 model 这里的model需要为私有的
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
     
    // MARK: - Intents
    
    func shffule() {
        model.shuffle()
    }
    
    // intend function —— 反应用户intend的方法
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
