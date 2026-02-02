//
//  CodeBreakerView.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 25/12/25.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Owned by Me
    @State private var game = CodeBreaker(pegChoices: [.brown, .yellow, .orange, .black])
    @State private var selection: Int = 0
    
    // MARK: - Body
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView {
                view(for: game.guess)
                
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            pegChooser
            
        }
        .padding()
    }
    
    var pegChooser: some View {
        HStack {
            ForEach(game.pegChoices, id: \.self) { peg in
                Button {
                    game.setGuessPeg(peg, at: selection)
                    selection = (selection + 1) % game.masterCode.pegs.count
                } label: {
                    PegView(peg: peg)
                }
                
            }
        }
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
                
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                PegView(peg: code.pegs[index])
                    .padding(Selection.border)
                    .background(backgroundView(for: code, at: index))
                    .onTapGesture {
                        if code.kind == .guess {
                            selection = index
                        }
                    }
            }
            Color.clear.aspectRatio(1, contentMode: .fit)
                .overlay(sideOverlay(for: code))
        }
    }
    
    private func backgroundView(for code: Code, at index: Int) -> some View {
        Group {
            if selection == index, code.kind == .guess {
                Selection.shape.foregroundStyle(Selection.color)
            } else {
                Color.clear
            }
        }
    }
    
    private func sideOverlay(for code: Code) -> some View {
        Group {
            if let matches = code.Matches {
                MatchMarkerView(matches: matches)
            } else if code.kind == .guess {
                guessButton
            }
        }
    }
    
    struct GuessButton {
        static let minimumFontSize: CGFloat = 8
        static let maximumFontSize: CGFloat = 80
        static let scaleFactor = minimumFontSize / maximumFontSize
    }
    
    struct Selection {
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let color: Color = Color.gray(0.85)
        static let shape = RoundedRectangle(cornerRadius: cornerRadius)
        
    }
}


extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

#Preview {
    CodeBreakerView()
}
