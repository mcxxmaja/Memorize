//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maja on 05/01/2024.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    
    @Published private var model: MemoryGame<String>
    private(set) var theme: Theme = Theme()
    
    static func createMemoryGame(emojis: [String], pairCount: Int) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: pairCount) {
            pairIndex in emojis[pairIndex] }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var color: Gradient {
        let colorsStr: [String] = theme.choosenTheme.color
        var colorsCol: [Color] = []
        for colorStr in colorsStr {
            colorsCol.append(EmojiMemoryGame.getColor(color: colorStr))
        }
        return Gradient(colors: colorsCol)
    }
    
    // MARK - Intents
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        theme.changeTheme()
        model = EmojiMemoryGame.createMemoryGame(
            emojis: theme.choosenTheme.emojiSet,
            pairCount:
                min(theme.choosenTheme.pairCount, theme.choosenTheme.emojiSet.count)
        )
    }
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(
            emojis: theme.choosenTheme.emojiSet,
            pairCount:
                min(theme.choosenTheme.pairCount, theme.choosenTheme.emojiSet.count)
        )
    }
    
    static func getColor(color: String) -> Color {
        switch color {
        case "blue":
            return .blue
        case "gray":
            return .gray
        case "orange":
            return .orange
        case "pink":
            return .pink
        case "red":
            return .red
        case "green":
            return .green
        case "black":
            return .black
        case "cyan":
            return .cyan
        case "yellow":
            return .yellow
        default:
            return .white
        }
    }
}
