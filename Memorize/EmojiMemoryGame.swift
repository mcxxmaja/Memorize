//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Maja on 05/01/2024.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    let choosenTheme: ThemeDetails
    
    //nie wiem czy viewmodel powinien cokolwiek trzymac.. czy theme powinno byc w modelu, ale z kolei to mowi o wygladzie i tam nie ma dostepu np do typu color
    let themeMap: [Theme : ThemeDetails] = [
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
    
    struct ThemeDetails {
        let name: String
        let emojiSet: [String]
        let pairCount: Int
        let color: Color
    }
    
    enum Theme {
        case holiday
        case renovation
        case sport
    }
    
    init(theme: Theme) {
        self.choosenTheme = themeMap[theme]!
    }
}
