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
    private(set) var lastTapTime = Date(timeInterval: 0, since: .now)
    private var indexOfTheOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach{ cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    var tapInterval: Double {
        lastTapTime.distance(to: .now)
    }
    
    mutating func choose(_ chosenCard: Card) {
        if let chosenIndex = getIndexOf(chosenCard),
           !cards[chosenIndex].isFaceUp
        {
            if let indexOfTheOnlyFaceUpCard {
                // second card tapped
                if isMatch(chosenCard, cards[indexOfTheOnlyFaceUpCard]) {
                    markMatched(cardIndex: indexOfTheOnlyFaceUpCard)
                    markMatched(cardIndex: chosenIndex)
                    addPoints(amount: 2)
                }
                cards[chosenIndex].isFaceUp.toggle()
            } else {
                // first card tapped
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
            if chosenCard.hasBeenSeen == true {
                distractPoints(amount: 1)
            }
            cards[chosenIndex].hasBeenSeen = true
        }
        updateLastTapTime()
    }
    
    mutating func markMatched(cardIndex: Int) {
        cards[cardIndex].isMatched = true
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
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable{
        let id: Int
        let content: CardContent
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false
    }
}

extension Array {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
