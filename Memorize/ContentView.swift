//
//  ContentView.swift
//  Memory
//
//  Created by 宋健星 on 2025/4/9.
//

import SwiftUI


// behave like a View
struct ContentView: View { // 这里的View并不是类型，而是协议
    // some View是body的类型，后面跟着的大括号是计算属性
    // 计算属性意味着body的值并非存储在某个地方，而是每次需要body的值的时候，计算
    // 属性中的代码将会运行，这也意味着每次获取body所获取的并非是固定的；
    // 并且，计算属性只能计算出变量的值，因此相当于该属性是只读的
    // some View意味着这个计算属性可以返回任何一个behave like a View的结构
    
    enum Themes{
        case holloweenTheme
        case vehicleTheme
        case animalsTheme
    }
    
    // 每组表情12个
    @State var emojis: Array<String> = []
    
    let holloweenEmojis: Array<String> = ["👻", "😈", "🎃", "🕷️", "💀", "❄️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"]
    
    let vehiclesEmojis: Array<String> = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓",
        "🚑", "🚒", "🚐", "🛻", "🚚"]
    
    let animalsEmojis: Array<String> = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻",
        "🐼", "🐻‍❄️", "🐨", "🐯", "🦁"]
    
    
    
    @State var cardCount: Int = 5
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeChoosers
//            Spacer()
//            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {  // 这里应该是尾随闭包，并且省略了return语句
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index], isFacedUp: false)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
    }

    
    var themeChoosers: some View {
        HStack{
            VStack {
                themeChooser(choose: Themes.animalsTheme, symbol: "cat")
                Text("animal").font(.body)
            }
            Spacer()
            VStack {
                themeChooser(choose: Themes.holloweenTheme, symbol: "flame")
                Text("holloween").font(.body)
            }
            Spacer()
            VStack {
                themeChooser(choose: Themes.vehicleTheme, symbol: "car")
                Text("vehicle").font(.body)
            }
        }
        .imageScale(.large)
        .font(.body)
        .foregroundColor(.blue)
    }
    
    func themeChooser(choose theme: Themes, symbol: String) -> some View {
        Button(action: {
            switch theme {
            case .animalsTheme:
                emojis = animalsEmojis.shuffled()
            case .holloweenTheme:
                emojis = holloweenEmojis.shuffled()
            case .vehicleTheme:
                emojis = vehiclesEmojis.shuffled()
            }
        }, label: {
            Image(systemName: symbol)
        })
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
     
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView: View {
    let content: String
    @State var isFacedUp = false
    
    var body: some View {
        // 这里也是一个尾随闭包 ZStack的最后一个输入参数是一个闭包
        ZStack {
            // @ViewBuilder里面也可以定义变量，例如base
            let base = RoundedRectangle(cornerRadius: 12)
            // 但是像 var x:Int = 1; x += 1这种代码不能出现
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFacedUp ? 1 : 0)
            base.fill().opacity(isFacedUp ? 0 : 1)
        }
        .onTapGesture {
            isFacedUp.toggle()
        }
    }
}







#Preview {
    ContentView()
}
