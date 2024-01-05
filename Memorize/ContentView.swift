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
    
    @State var emojiCount = 16
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 100 ))]) {
                    ForEach(emojis[0..<min(emojiCount,emojis.count)], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                themeButton(symbolName: "car", buttonText: "Vehicles", onClickMethod: {emojis = vehicles; emojis.shuffle(); emojiCount = 12})
                themeButton(symbolName: "cart", buttonText: "Food", onClickMethod: {emojis = food; emojis.shuffle(); emojiCount = 15})
                themeButton(symbolName: "hare", buttonText: "Animals", onClickMethod: {emojis = animals; emojis.shuffle(); emojiCount = 9})
            }
        }
        .padding(.horizontal)
    }
    
    func onButtonClick(theme: [String], cardCount: Int) {
        emojis = theme
        emojis.shuffle()
        emojiCount = cardCount
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
