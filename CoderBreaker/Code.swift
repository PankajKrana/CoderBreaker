import SwiftUI

struct Code {
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Peg.missing, count: 4)
    
    static let missingPeg: Peg = .clear
    
    enum Kind: Equatable {
        case master
        case guess
        case attempts([Match])
        case unknown
    }
    
    mutating func randomize(from pegChoises: [Peg]) {
        for index in pegChoises.indices {
            pegs[index] = pegChoises.randomElement() ?? Code.missingPeg
        }
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