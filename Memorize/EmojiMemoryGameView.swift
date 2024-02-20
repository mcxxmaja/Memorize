//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Maja on 27/12/2023.
//

import SwiftUI
import SwiftData

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(game.theme.choosenTheme.name).font(.title)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card, color: game.color)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            .padding()
            let score = String(format: "%.1f", game.score)
            Text("Score: \(score)")
//            Text("Tap interval: \(viewModel.model.tapInterval)")
            Button {
                game.newGame()
            } label: {
                Text("New Game").font(.title)
            }
        }
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    let color: Gradient
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp || card.isMatched {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0)
                Text(card.content)
                    .font(.largeTitle)
                    .padding(1) //.frame(width: 50, height: 50)
            } else {
                shape.fill(color)
                shape.strokeBorder(lineWidth: 3.0)
            }
        }
    }
}




 































let game = EmojiMemoryGame()

#Preview {
    EmojiMemoryGameView(game: game)
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.landscapeRight)
    
}

#Preview {
    EmojiMemoryGameView(game: game)
        .preferredColorScheme(.light)
}
