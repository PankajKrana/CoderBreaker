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
    var pegChoices: [Peg] = [.red, .blue, .yellow, .green]
    
    
    init(pegChoices: [Peg] = [.red, .green, .yellow, .blue]) {
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
        print(masterCode)
    }
    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempts(guess.match(against: masterCode))
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
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4)
    
    static let missing: Peg = .clear
    
    enum Kind: Equatable {
        case master
        case guess
        case attempts([Match])
        case unknown
    }
    
    mutating func randomize(from pegChoises: [Peg]) {
        for index in pegChoises.indices {
            pegs[index] = pegChoises.randomElement() ?? Code.missing
        }
    }
    
    var Matches: [Match] {
        switch kind {
        case .attempts(let matches):
            return matches
        default: return []
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                results[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        for index in pegs.indices {
            if results[index] != .exact {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    results[index] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        return results
    }
}


