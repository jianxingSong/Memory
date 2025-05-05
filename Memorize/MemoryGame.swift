//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 宋健星 on 2025/4/26.
//

import Foundation

// the model
struct MemoryGame<CardContent> where CardContent: Equatable {
    // private(Set)表示只有在set这个变量的时候才是私有的，如果只是读取访问这个变量的话是公开的
    private(set) var cards: Array<Card>
    
    // 构造函数
    init(numberOfPairOfCard: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairOfCard) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    // 用来判断当前是否已经翻了一张牌
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter{index in cards[index].isFaceUp}.only }
        set { return cards.indices.forEach {cards[$0].isFaceUp = ($0 == newValue)} }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            // 选中的卡必须是朝下并且没有匹配过的
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                // 如果之前已经有一张卡片翻面了
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    // 判断选中卡片与之前所选卡片是否相同
                    if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                    }
                } else { // 如果之前没有选择卡片
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    // 本来Equatable协议要求需要定义==符号，但是swift中只要所有成员变量是Equatable的，则这个结构体就是满足Equatable的
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        
        var id: String
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "Face up" : "Face down") \(isMatched ? "Matched" : "Unmatched")"
        }
    }
}

extension Array {
    var only: Element? {
        self.count == 1 ? self.first : nil
    }
}
