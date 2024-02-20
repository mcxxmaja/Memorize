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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
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
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornetRadius)
                if card.isFaceUp || card.isMatched {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3.0)
                    Text(card.content).font(font(of: geometry.size))
                } else {
                    shape.fill(color)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                }
            }
        })
    }
     
    private func font(of size: CGSize) -> Font {
        Font.system(size: DrawingConstants.fontScale * min(size.width, size.height))
    }
    
    private struct DrawingConstants {
        static let cornetRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
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
