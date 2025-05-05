//
//  EmojiMemoryGameView.swift
//  Memory
//
//  Created by 宋健星 on 2025/4/9.
//

import SwiftUI


// behave like a View
struct EmojiMemoryGameView: View { // 这里的View并不是类型，而是协议
    // some View是body的类型，后面跟着的大括号是计算属性
    // 计算属性意味着body的值并非存储在某个地方，而是每次需要body的值的时候，计算
    // 属性中的代码将会运行，这也意味着每次获取body所获取的并非是固定的；
    // 并且，计算属性只能计算出变量的值，因此相当于该属性是只读的
    // some View意味着这个计算属性可以返回任何一个behave like a View的结构
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button("shuffle") {
                viewModel.shffule()
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing:  0) {  // 这里应该是尾随闭包，并且省略了return语句
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        // 这里也是一个尾随闭包 ZStack的最后一个输入参数是一个闭包
        ZStack {
            // @ViewBuilder里面也可以定义变量，例如base
            let base = RoundedRectangle(cornerRadius: 12)
            // 但是像 var x:Int = 1; x += 1这种代码不能出现
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}







#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
