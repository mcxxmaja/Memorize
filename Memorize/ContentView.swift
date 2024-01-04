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
                Button {
                    onButtonClick(theme: vehicles, cardCount: 15)
                } label: {
                    VStack {
                        Image(systemName: "car").font(.title)
                        Text("Vehicles").font(.footnote)
                    }
                }
                .padding(.horizontal)
                Button {
                    onButtonClick(theme: animals, cardCount: 9)
                } label: {
                    VStack {
                        Image(systemName: "hare").font(.title)
                        Text("Animals").font(.footnote)
                    }
                }
                .padding()
                Button {
                    onButtonClick(theme: food, cardCount: 12)
                } label: {
                    VStack {
                        Image(systemName: "cart").font(.title)
                        Text("Food").font(.footnote)
                    }
                }
                .padding()
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
}

#Preview {
    ContentView()
        .preferredColorScheme(.light)
}
