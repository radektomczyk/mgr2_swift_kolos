//
//  MemoGameViewModel.swift
//  CoreProject
//
//  Created by Paweł Powroźnik on 04/12/2024.
//

import SwiftUI

class MemoGameViewModel: ObservableObject {
    private static var currentEmoijs = ["🦊","🐧","🦙","🐘","🐫","🐊","🐠","🦑","🦐","🦧","🐄","🐖"]
    
    @Published private var model = createMemoryGame()

    // ZADANIE 2
    @Published var moveCounter = 0
    // ZADANIE 3
    @Published var hasWon = false
    
    // MARK: - Konstruktor
    private static func createMemoryGame() -> MemoGameModel<String> {
        return MemoGameModel<String>(numberOfCards: currentEmoijs.count) { index in
            if (currentEmoijs.indices.contains(index)) {
                return currentEmoijs[index]
            } else {
                return "⁇"
            }
        }
    }
    
    var cards: Array<MemoGameModel<String>.Card> {
        return model.cards
    }
    
    // Kolor główny aplikacji
    var gameColor: Color {
        .blue
    }
    
    //MARK: - Intends
    
    func getMainCard()->MemoGameModel<String>.Card? {
        return model.mainCard
    }

    // Wywoływane po onTapGesture w ContentView
    // ====== MOVE COUNTER + RESTART
    func choose(_ card: MemoGameModel<String>.Card) {
        // ZADANIE 2
        moveCounter += 1
        model.choose(card)
        hasWon = model.checkWin()
    }
    
    func shuffle() {
        model.shuffle()
    }

    // ZADANIE 3
    func restart(){
        model = MemoGameViewModel.createMemoryGame()
        // ZADANIE 2
        moveCounter = 0
        // ZADANIE 3
        hasWon = false
    }
}
 
