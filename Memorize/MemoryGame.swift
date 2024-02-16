//
//  MemoryGame.swift
//  Memorize
//
//  Created by Maja on 05/01/2024.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Double = 0
    private var indexOfTheOnlyFaceUpCard: Int?
    private(set) var lastTapTime: Date = Date(timeInterval: 0, since: .now)
    var tapInterval: Double {
        lastTapTime.distance(to: .now)
    }
    
    mutating func choose(_ chosenCard: Card) {
        if let chosenIndex = getIndexOf(chosenCard),
           !cards[chosenIndex].isFaceUp
        {
            if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                // second card uncovered
                if isMatch(chosenCard, cards[potentialMatchIndex]) {
                    markMatched(cardIndex: potentialMatchIndex)
                    markMatched(cardIndex: chosenIndex)
                    addPoints(amount: 2)
                }
                indexOfTheOnlyFaceUpCard = nil
            } else {
                // first card uncovered
                coverAllCards()
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
            if chosenCard.hasBeenSeen == true {
                distractPoints(amount: 1)
            }
            cards[chosenIndex].isFaceUp.toggle()
            cards[chosenIndex].hasBeenSeen = true
        }
        updateLastTapTime()
    }
    
    mutating func markMatched(cardIndex: Int) {
        cards[cardIndex].isMatched = true
    }
    
    mutating func coverAllCards() {
        for index in cards.indices {
            cards[index].isFaceUp = false
        }
    }
    
    mutating func distractPoints(amount: Int) {
        let multiplied: Double = Double(amount) * tapInterval
        adjustScore(by: -multiplied)
    }
    
    mutating func addPoints(amount: Int) {
        let multiplied: Double = Double(amount) / tapInterval
        adjustScore(by: multiplied)
    }
    
    
    mutating func adjustScore(by amount: Double) {
        score += amount
    }
    
    mutating func updateLastTapTime() {
        lastTapTime = .now
    }

    func getIndexOf(_ card: Card) -> Int? {
        return cards.firstIndex(where: { $0.id == card.id })
    }
    
    func isMatch(_ card1: Card, _ card2: Card) -> Bool {
        return card1.content == card2.content
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable{
        var id: Int
        var content: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
    }
}
