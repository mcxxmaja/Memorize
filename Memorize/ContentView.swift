//
//  ContentView.swift
//  Memorize
//
//  Created by Maja on 27/12/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var emojis = [
                    ["🚄", "✈️", "🏍️", "🚁", "🛳️", "🛴", "🚜", "🚚",
                  "🚃", "🚘", "🚠", "🚲", "🚌", "🚂", "🛥️", "⛵️"],
                    
                    ["🐶", "🐱", "🐭", "🐹", "🦊", "🐷", "🐵", "🐧",
                  "🐻", "🐯", "🐨", "🐮", "🐸", "🐰", "🐴", "🐺"],

                    ["🍏", "🍣", "🥙", "🍟", "🍤", "🥟", "🍲", "🍜",
                  "🍔", "🥬", "🫛", "🍞", "🍒", "🥨", "🍠", "🥯"]
                    ]
    @State var emojiCount = 16
    @State var theme = 0
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 100 ))]) {
                    ForEach(emojis[theme][0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            Button {
                theme += 1 
                theme %= 3
                emojis[theme].shuffle()
                emojiCount = 3 * theme + 8
            } label: {
                Text("Change theme")
            }

        }
        .padding(.horizontal)
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
