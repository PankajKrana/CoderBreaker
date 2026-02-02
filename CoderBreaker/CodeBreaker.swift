//
//  CodeBreaker.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 20/01/26.
//

import SwiftUI

typealias Peg = Color

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    var pegChoices: [Peg]
    
    init(pegChoices: [Peg] = [.red, .green, .yellow, .blue]) {
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
        print(masterCode)
    }
    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempts(guess.match(against: masterCode))
        attempts.append(attempt)
        guess.reset()
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guess.pegs[index] = peg
    }
    
    mutating func changeGuessPeg(at index : Int){
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoisces = pegChoices.firstIndex(of: existingPeg){
            
            let newPeg = pegChoices[(indexOfExistingPegInPegChoisces + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        }else{
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
    }
}

extension Peg {
    static let missing = Color.clear
}




