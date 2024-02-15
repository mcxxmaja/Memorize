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
        VStack {
            Text(viewModel.theme.choosenTheme.name).font(.title)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, color: viewModel.color)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .padding()
            Text("Score: \(viewModel.score)") //TODO: format better
            Text("Last Tap: \(viewModel.lastTapTime.formatted())") //TODO: remove
            Text("Tap interval: \(viewModel.model.tapInterval)")
            Button {
                viewModel.newGame()
            } label: {
                Text("New Game").font(.title)
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
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
    ContentView(viewModel: game)
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.landscapeRight)
    
}

#Preview {
    ContentView(viewModel: game)
        .preferredColorScheme(.light)
}
