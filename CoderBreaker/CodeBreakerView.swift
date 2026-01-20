//
//  CodeBreakerView.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 25/12/25.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker()
    
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView {
                view(for: game.guess)
                
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            
            Button("Guess") {
                withAnimation {
                    game.attemptGuess()
                    
                }
            }
            
        }
        .padding()
    }
    
    
    func view(for code: Code) -> some View {
        
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
                
            }
            
            MatchMarkerView(matches: [.exact, .inexact, .nomatch, .exact])
            
        }
    }
}


#Preview {
    CodeBreakerView()
}
