//
//  Code.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 02/02/26.
//


import SwiftUI

struct Code {
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Peg.missing, count: 4)
    
    static let missingPeg: Peg = .clear
    
    enum Kind: Equatable {
        case master(Bool)
        case guess
        case attempts([Match])
        case unknown
    }
    
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden): return isHidden
        default: return false
        }
    }
    
    mutating func randomize(from pegChoises: [Peg]) {
        for index in pegs.indices {
            pegs[index] = pegChoises.randomElement() ?? Code.missingPeg
        }
        print(self)

    }
    
    mutating func reset() {
        pegs = Array(repeating: Code.missingPeg, count: 4)
    }
    
    var Matches: [Match]? {
        switch kind {
        case .attempts(let matches):
            return matches
        default: return nil
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var pegsToMatch = otherCode.pegs
        let backwardsExactMatches = pegs.indices.reversed().map { index in
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                return Match.exact
            } else {
                return .nomatch
            }
            
        }
        let exactMatches = Array(backwardsExactMatches.reversed())
        
        return pegs.indices.map { index in
            if exactMatches[index] != .exact,  let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            } else {
                return exactMatches[index]
            }
        }
        
    }
}
