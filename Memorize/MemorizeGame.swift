//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 宋健星 on 2025/4/26.
//

import Foundation

struct CardGame<CardContent> {
    var cards: Array<Card>
    
    func choose() {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
