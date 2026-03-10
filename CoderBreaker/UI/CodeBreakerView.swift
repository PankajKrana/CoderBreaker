//
//  CodeBreakerView.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 25/12/25.
//

import SwiftUI

struct CodeBreakerView: View {
    
    // MARK: Data Owned by Me
    let game: CodeBreaker
    @State private var selection: Int = 0
    @State private var restarting: Bool = false
    @State private var hideMostRecentMarkers: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            CodeView(code: game.masterCode)
            ScrollView {
                if !game.isOver {
                    CodeView(code: game.guess, selection: $selection) { guessButton }
                        .animation(nil, value: game.attempts.count)
                        .opacity(restarting ? 0 : 1)
                }
                ForEach(game.attempts, id: \.pegs) { attemp in
                    CodeView(code: attemp) {
                        let showMarkers = !hideMostRecentMarkers || attemp.pegs != game.attempts.first?.pegs
                        if showMarkers, let matches = attemp.Matches {
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
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Restart", systemImage: "arrow.circlepath", action: restart)
                
            }
            ToolbarItem {
                ElapsedTime(startTime: game.startTime, endTime: game.endTime)
                    .monospaced()
                    .lineLimit(1)
                
            }
        }
        .padding()
    }
    
    func changedPegAtSelection(to peg: Peg) {
        game.setGuessPeg(peg, at: selection)
        selection = (selection + 1) % game.masterCode.pegs.count
    }
    
    func restart() {
        withAnimation(.restart) {
            restarting = game.isOver
            game.restart()
            selection = 0

        } completion: {
            withAnimation(.restart) {
                restarting = false
            }
        }
  
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
    @Previewable @State var game = CodeBreaker(name: "game", pegChoices: [.red, .blue, .black])
    NavigationStack {
        CodeBreakerView(game: game)
    }
}
