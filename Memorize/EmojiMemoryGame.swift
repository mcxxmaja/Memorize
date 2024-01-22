//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maja on 05/01/2024.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    var choosenTheme: ThemeDetails

    var themeMap: [Theme : ThemeDetails] = [
        .holiday : ThemeDetails(
            name: "Holiday",
            emojiSet: ["🏝️", "🏖️", "🚢", "🗺️", "🛳️", "⛱️", "☀️", "👙", "🩳", "🐚", "⛴️", "⛵️", "🛶", "🤿", "🍹", "🛫"],
            pairCount: 5,
            color: .blue),
        .renovation : ThemeDetails(
            name: "Renovation",
            emojiSet: ["🔨", "🎨", "🖼️", "🛋️", "🪑", "🛏️"],
            pairCount: 10,
            color: .gray),
        .sport:ThemeDetails(
            name: "Sport",
            emojiSet: ["⚽️", "🏀", "🏉", "🎾", "🏐", "🎱", "⚾️", "🥏", "🥎"],
            pairCount: 6,
            color: .orange)
    ]
    
    static func createMemoryGame(emojis: [String], pairCount: Int) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: pairCount) {
            pairIndex in emojis[pairIndex] }
    }
    
    func getColor() -> Color {
        return choosenTheme.color
    }
    
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK - Intents
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    struct ThemeDetails {
        let name: String
        var emojiSet: [String]
        let pairCount: Int
        let color: Color
    }
    
    enum Theme {
        case holiday
        case renovation
        case sport
    }
    
    init(theme: Theme) {
        choosenTheme = themeMap[theme]!
        choosenTheme.emojiSet.shuffle()
        model = EmojiMemoryGame.createMemoryGame(emojis: choosenTheme.emojiSet, pairCount: min(choosenTheme.pairCount, choosenTheme.emojiSet.count))
    }
}
