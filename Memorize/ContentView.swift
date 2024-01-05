//
//  ContentView.swift
//  Memorize
//
//  Created by Maja on 27/12/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    let vehicles = ["🚄", "✈️", "🏍️", "🚁", "🛳️", "🛴", "🚜", "🚚",
                  "🚃", "🚘", "🚠", "🚲", "🚌", "🚂", "🛥️", "⛵️"]
                    
    let animals = ["🐶", "🐱", "🐭", "🐹", "🦊", "🐷", "🐵", "🐧",
                  "🐻", "🐯", "🐨", "🐮", "🐸", "🐰", "🐴", "🐺"]

    let food = ["🍏", "🍣", "🥙", "🍟", "🍤", "🥟", "🍲", "🍜",
                  "🍔", "🥬", "🫛", "🍞", "🍒", "🥨", "🍠", "🥯"]
    
    @State var emojis : [String] = []
    @State var cardCount = 16
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: cardCount), maximum: widthThatBestFits(cardCount: cardCount) ))]) {
                    ForEach(emojis[0..<min(cardCount,emojis.count)], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                let codeSnippet = {
                    emojis.shuffle()
                    cardCount = Int.random(in: 4..<emojis.count)
                }
                themeButton(symbolName: "car", buttonText: "Vehicles", onClickMethod: {emojis = vehicles; codeSnippet()})
                themeButton(symbolName: "cart", buttonText: "Food", onClickMethod: {emojis = food; codeSnippet()})
                themeButton(symbolName: "hare", buttonText: "Animals", onClickMethod: {emojis = animals; codeSnippet()})
            }
        }
        .padding(.horizontal)
    }
}

func widthThatBestFits(cardCount: Int) -> CGFloat {
    if cardCount > 9 { // 4 columns
        return 75
    } else if cardCount > 4 { // 3 columns
        return 100
    }
    return 150 // 2 columns
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
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3.0)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}




 
































#Preview {
    ContentView()
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.landscapeRight)
    
}

#Preview {
    ContentView()
        .preferredColorScheme(.light)
}
