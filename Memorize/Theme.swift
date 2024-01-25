//
//  GameThemes.swift
//  Memorize
//
//  Created by Maja on 25/01/2024.
//

import Foundation

struct Theme {
    var choosenTheme: ThemeDetails
    
    init() {
        self.choosenTheme = themeList[Int.random(in: 0..<themeList.count)]
        choosenTheme.shuffleEmojis() //TODO: theme nie powinien shufflowac raczej
    }
    
    mutating func changeTheme() {
        choosenTheme = themeList[Int.random(in: 0..<themeList.count)]
        choosenTheme.shuffleEmojis()
    }
    
    var themeList: [ThemeDetails] = [
        ThemeDetails(
            name: "Holiday",
            emojiSet: ["🏝️", "🏖️", "🚢", "🗺️", "🛳️", "⛱️", "☀️", "👙", "🩳", "🐚", "⛴️", "⛵️", "🛶", "🤿", "🍹", "🛫"],
            pairCount: 5,
            color: "blue"),
        ThemeDetails(
            name: "Renovation",
            emojiSet: ["🔨", "🎨", "🖼️", "🛋️", "🪑", "🛏️"],
            pairCount: 10,
            color: "gray"),
        ThemeDetails(
            name: "Sport",
            emojiSet: ["⚽️", "🏀", "🏉", "🎾", "🏐", "🎱", "⚾️", "🥏", "🥎"],
            pairCount: 6,
            color: "orange"),
        ThemeDetails(
            name: "Fruit",
            emojiSet: ["🍏", "🍊", "🍍", "🥝", "🫐", "🍓", "🍌", "🍋", "🍉", "🍐"],
            pairCount: 8,
            color: "green"),
        ThemeDetails(
            name: "Heart",
            emojiSet: ["🩷", "❤️", "🧡", "💛", "💚", "🩵", "💙", "💜", "🤎", "🤍", "🩶", "🖤"],
            pairCount: 12,
            color: "pink"),
        ThemeDetails(
            name: "Cards",
            emojiSet: ["♠️", "♣️", "♥️", "♦️"],
            pairCount: 10,
            color: "red")
    ]

    struct ThemeDetails {
        let name: String
        var emojiSet: [String]
        let pairCount: Int
        let color: String
        
        mutating func shuffleEmojis() {
            emojiSet.shuffle()
        }
    }
}
