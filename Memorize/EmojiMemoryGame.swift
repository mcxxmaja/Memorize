//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maja on 05/01/2024.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    
    static let emojis = ["🍏", "🍣", "🥙", "🍟", "🍤", "🥟", "🍲", "🍜", "🍔", "🥬", "🫛", "🍞", "🍒", "🥨", "🍠", "🥯"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 5) {pairIndex in emojis[pairIndex] }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK - Intents
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
