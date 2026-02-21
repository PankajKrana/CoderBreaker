//
//  CodeBreakerView.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 25/12/25.
//

import SwiftUI

struct CodeBreakerView: View {
    
    // MARK: Data Owned by Me
    @State private var game = CodeBreaker(pegChoices: [.brown, .yellow, .orange, .black, .green])
    @State private var selection: Int = 0
    @State private var restarting: Bool = false
    @State private var hideMostRecentMarkers: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            Button("Restart", systemImage: "arrow.circlepath") {
                withAnimation(.restart) {
                    restarting = true
                } completion: {
                    withAnimation(.restart) {
                        game.restart()
                        selection = 0
                    }
                    
                }
            }
            
            CodeView(code: game.masterCode)
            ScrollView {
                if !game.isOver || restarting {
                    CodeView(code: game.guess, selection: $selection) { guessButton }
                         .animation(nil, value: game.attempts.count)
                         .opacity(restarting ? 0 : 1)
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    CodeView(code: game.attempts[index]) {
                        let showMarkers = !hideMostRecentMarkers || index != game.attempts.count - 1
                        if showMarkers, let matches = game.attempts[index].Matches {
                            MatchMarkerView(matches: matches)
                        }
                    }
                    .transition(AnyTransition.attemp(game.isOver))
                }
            }
            if !game.isOver {
                PegChooser(choices: game.pegChoices, onChoose: changedPegAtSelection)
                    .transition(.pegChooser)
            }
        }
        .padding()
    }
    
    func changedPegAtSelection(to peg: Peg) {
            game.setGuessPeg(peg, at: selection)
            selection = (selection + 1) % game.masterCode.pegs.count
    }
    
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation(.guess) {
                game.attemptGuess()
                selection = 0
                hideMostRecentMarkers = true
            } completion: {
                withAnimation(.guess) {
                    hideMostRecentMarkers = false
                }
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    struct GuessButton {
        static let minimumFontSize: CGFloat = 8
        static let maximumFontSize: CGFloat = 80
        static let scaleFactor = minimumFontSize / maximumFontSize
    }
    
}

#Preview {
    CodeBreakerView()
}
