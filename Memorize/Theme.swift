//
//  GameThemes.swift
//  Memorize
//
//  Created by Maja on 25/01/2024.
//

import Foundation

struct Theme {
    private(set) var choosenTheme: ThemeDetails
    
    init() {
        self.choosenTheme = themeList[Int.random(in: 0..<themeList.count)]
        choosenTheme.shuffleEmojis()
    }
    
    mutating func changeTheme() {
        choosenTheme = themeList[Int.random(in: 0..<themeList.count)]
        choosenTheme.shuffleEmojis()
    }
    
    private var themeList: [ThemeDetails] = [
        ThemeDetails(
            name: "Holiday",
            emojiSet: ["🏝️", "🏖️", "🚢", "🗺️", "🛳️", "⛱️", "☀️", "👙", "🩳", "🐚", "⛴️", "⛵️", "🛶", "🤿", "🍹", "🛫"],
            color: "blue", 
            numOfPairsToGenerate: 8),
        ThemeDetails(
            name: "Renovation",
            emojiSet: ["🔨", "🎨", "🖼️", "🛋️", "🪑", "🛏️"],
            color: "gray",
            numOfPairsToGenerate: 10),
        ThemeDetails(
            name: "Sport",
            emojiSet: ["⚽️", "🏀", "🏉", "🎾", "🏐", "🎱", "⚾️", "🥏", "🥎"],
            color: "orange", 
            numOfPairsToGenerate: 9),
        ThemeDetails(
            name: "Fruit",
            emojiSet: ["🍏", "🍊", "🍍", "🥝", "🫐", "🍓", "🍌", "🍋", "🍉", "🍐"],
            color: "green",
            numOfPairsToGenerate: .randomNumber),
        ThemeDetails(
            name: "Heart",
            emojiSet: ["🩷", "❤️", "🧡", "💛", "💚", "🩵", "💙", "💜", "🤎", "🤍", "🩶", "🖤"],
            color: "pink", 
            numOfPairsToGenerate: .randomNumber),
        ThemeDetails(
            name: "Cards",
            emojiSet: ["♠️", "♣️", "♥️", "♦️"],
            color: "red", 
            numOfPairsToGenerate: .maxNumber)
    ]

    struct ThemeDetails {
        let name: String
        var emojiSet: [String]
        private var pairCountAssigned: Int?
        let color: String
        
        var pairCount: Int {
            get {
                pairCountAssigned ?? Int.random(in: 2...emojiSet.count)
            }
        }

        // SPECIFIC NUMBER
        init(name: String, emojiSet: [String], color: String, numOfPairsToGenerate pairCount: Int) {
            self.name = name
            self.emojiSet = emojiSet
            self.color = color
            self.pairCountAssigned = pairCount
        }
        
        // EMOJI COUNT / RANDOM NUMBER
        init(name: String, emojiSet: [String], color: String, numOfPairsToGenerate: GenerateCards) {
            self.name = name
            self.emojiSet = emojiSet
            self.color = color
            if .maxNumber == numOfPairsToGenerate {
                self.pairCountAssigned = emojiSet.count
            }
        }
        
        mutating func shuffleEmojis() {
            emojiSet.shuffle()
        }
        
        enum GenerateCards {
            case randomNumber
            case maxNumber
        }
    }
}
