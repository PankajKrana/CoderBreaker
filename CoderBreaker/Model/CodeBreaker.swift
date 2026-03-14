//
//  CodeBreaker.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 20/01/26.
//

import SwiftUI

typealias Peg = Color

@Observable class CodeBreaker {
    
    var name: String
    var masterCode: Code = Code(kind: .master(true))
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    var pegChoices: [Peg]
    var startTime: Date?
    var endTime: Date?
    var elapsedTime: TimeInterval = 0
    
    init(name: String = "Code Breaker", pegChoices: [Peg] = [.red, .green, .yellow, .blue]) {
        self.name = name
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
    }
    
    func startTimer() {
        if startTime == nil, !isOver {
            startTime = .now
        }
    }
    
    func pauseTimer() {
        if let startTime {
            elapsedTime += Date.now.timeIntervalSince(startTime)
        }
        startTime = nil
    }
    
    var isOver: Bool {
        attempts.first?.pegs == masterCode.pegs
    }
    
    func restart() {
        masterCode.kind = .master(true)
        masterCode.randomize(from: pegChoices)
        guess.reset()
        attempts.removeAll()
        startTime = .now
        endTime = nil
    }
    
    
    func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempts(guess.match(against: masterCode))
        attempts.insert(attempt, at: 0 )
        guess.reset()
        if isOver {
            endTime = .now
            masterCode.kind = .master(false)
            pauseTimer()
        }
    }
    
    func setGuessPeg(_ peg: Peg, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guess.pegs[index] = peg
    }
    
    func changeGuessPeg(at index : Int){
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoisces = pegChoices.firstIndex(of: existingPeg){
            
            let newPeg = pegChoices[(indexOfExistingPegInPegChoisces + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        }else{
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
    }
}

extension CodeBreaker: Identifiable, Hashable, Equatable {
    
    // MARK: Making CodeBreaker Equatable
    static func == (lhs: CodeBreaker, rhs: CodeBreaker) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: Making CodeBreaker Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

extension Peg {
    static let missing = Color.clear
}




