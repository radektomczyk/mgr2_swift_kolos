//
//  MemoGameModel.swift
//  CoreProject
//
//  Created by Paweł Powroźnik on 04/12/2024.
//

import Foundation

struct MemoGameModel<CardContent> where CardContent : Equatable {
    private(set) var cards: Array<Card>
    private(set) var mainCard: Card? = nil
    
    init(numberOfCards: Int, cardContentFactory: (Int)-> CardContent) {
        cards = []
        let mainCardNumber = Int.random(in: 0..<numberOfCards)
        for index in 0..<numberOfCards {
            let content: CardContent = cardContentFactory(index)
            cards.append(Card(content: content, id: "\(index)a"))
            if mainCardNumber == index {
                //utwórz kartę główną
                self.mainCard = Card(content: content, id: "\(index)b")
                self.mainCard?.isFaceUp = true
            }
        }
    }
    
    mutating func choose(_ card:Card) {
        if let chosenIndex = index(of: card) {
            cards[chosenIndex].isFaceUp.toggle()
            if getCardNumber(mainCard!) == getCardNumber(cards[chosenIndex]){
                mainCard?.isMached = true
                cards[chosenIndex].isMached = true
                changeVisible()
            } else {
                if let indexOfFacedUpCard = indexOfFacedUpCard(card) {
                    cards[indexOfFacedUpCard].isFaceUp = false
                }
            }
        }
    }
    
    mutating func shuffle() {
         cards.shuffle()
    }

    // ZADANIE 4
    func chechWin() -> Bool {
        cards.allSatisfy { $0.isMached || !$0.isVisible }
    }

    //Zwraca numer karty bez litery na koncu
    private func getCardNumber(_ card: Card) -> String {
        let id = card.id
        return String(id[..<id.index(before: id.endIndex)])
    }
    
    private mutating func changeVisible() {
        for index in cards.indices {
            if !cards[index].isMached {
                cards[index].isVisible = false
            }
        }
    }
    
    //Zwraca indeks karty, która jest odwróceona, a która nie została
    //aktualnie wybrana (poprzednio odsłonięta)
    private func indexOfFacedUpCard(_ card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].isFaceUp {
                if cards[index].id != card.id {
                    return index
                }
            }
        }
        return nil
    }
    
    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    struct Card : Equatable, Identifiable {
        
        var isFaceUp = false
        var isMached = false
        var isVisible = true
        let content: CardContent
        var id: String
    }
}
