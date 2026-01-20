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
    let pegChoices: [Peg] = [.red, .blue, .yellow, .green]
    
    
    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempts
        attempts.append(attempt)
    }
    
    mutating func changeGuessPeg(at index : Int){
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoisces = pegChoices.firstIndex(of: existingPeg){
            
            let newPeg = pegChoices[(indexOfExistingPegInPegChoisces + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        }else{
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
    
}


struct Code {
    var kind: Kind
    var pegs: [Peg] = [.green, .blue, .red, .green]
    
    static let missing: Peg = .clear
    
    enum Kind {
        case master
        case guess
        case attempts
        case unknown
    }
}


