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
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(viewModel.getColor(color: viewModel.theme.choosenTheme.color))
            .padding()
            Text("Score: \(viewModel.score)")
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
                shape.fill()
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
