//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maja on 05/01/2024.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    var choosenTheme: Theme
    
    static func createMemoryGame(emojis: [String], pairCount: Int) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: pairCount) {
            pairIndex in emojis[pairIndex] }
    }
    
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK - Intents
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        let themeCount = themeList.count
        choosenTheme = themeList[Int.random(in: 0..<themeCount)]
        choosenTheme.emojiSet.shuffle()
        model = EmojiMemoryGame.createMemoryGame(emojis: choosenTheme.emojiSet, pairCount: min(choosenTheme.pairCount, choosenTheme.emojiSet.count))
    }
    
    init() {
        let themeCount = themeList.count
        choosenTheme = themeList[Int.random(in: 0..<themeCount)]
        choosenTheme.emojiSet.shuffle()
        model = EmojiMemoryGame.createMemoryGame(emojis: choosenTheme.emojiSet, pairCount: min(choosenTheme.pairCount, choosenTheme.emojiSet.count))
    }
    
    var themeList: [Theme] = [
        Theme(
            name: "Holiday",
            emojiSet: ["🏝️", "🏖️", "🚢", "🗺️", "🛳️", "⛱️", "☀️", "👙", "🩳", "🐚", "⛴️", "⛵️", "🛶", "🤿", "🍹", "🛫"],
            pairCount: 5,
            color: .blue),
        Theme(
            name: "Renovation",
            emojiSet: ["🔨", "🎨", "🖼️", "🛋️", "🪑", "🛏️"],
            pairCount: 10,
            color: .gray),
        Theme(
            name: "Sport",
            emojiSet: ["⚽️", "🏀", "🏉", "🎾", "🏐", "🎱", "⚾️", "🥏", "🥎"],
            pairCount: 6,
            color: .orange),
        Theme(
            name: "Fruit",
            emojiSet: ["🍏", "🍊", "🍍", "🥝", "🫐", "🍓", "🍌", "🍋", "🍉", "🍐"],
            pairCount: 8,
            color: .pink),
        Theme(
            name: "Heart",
            emojiSet: ["🩷", "❤️", "🧡", "💛", "💚", "🩵", "💙", "💜", "🤎", "🤍", "🩶", "🖤"],
            pairCount: 12,
            color: .white)
    ]
    
    struct Theme {
        let name: String
        var emojiSet: [String]
        let pairCount: Int
        let color: Color
    }
}
