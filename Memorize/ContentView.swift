//
//  ContentView.swift
//  Memorize
//
//  Created by Maja on 27/12/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding()
    }
}

struct themeButton: View {
    var symbolName: String
    var buttonText: String
    var onClickMethod: () -> ()

    
    var body: some View {
        Button {
            onClickMethod()
        } label: {
            VStack {
                Image(systemName: symbolName).font(.title)
                Text(buttonText).font(.footnote)
            }
        }
        .padding()
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp || card.isMatched {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0)
                Text(card.content).font(.largeTitle)
//            } else if card.isMatched {
//                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}




 































let game = EmojiMemoryGame()

#Preview {
    ContentView(viewModel: game)
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.landscapeRight)
    
}

#Preview {
    ContentView(viewModel: game)
        .preferredColorScheme(.light)
}
