//
//  GameChooser.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 10/03/26.
//

import SwiftUI

struct GameChooser: View {
    // MARK: Data Owned by Me
    @State private var game: [CodeBreaker] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(game) { game in
                    NavigationLink(value: game) {
                        GameSummary(game: game)
                    }
                    NavigationLink(value: game.masterCode.pegs) {
                        Text("Cheat")
                    }
                }
                .onDelete { offsets in
                    game.remove(atOffsets: offsets)
                }
                .onMove { offsets, destination in
                    game.move(fromOffsets: offsets, toOffset: destination)
                }
            }
            .navigationDestination(for: CodeBreaker.self) { game in
                CodeBreakerView(game: game)
            }
            .navigationDestination(for: [Peg].self) { pegs in
                PegChooser(choices: pegs)
            }
            .listStyle(.plain)
            .toolbar {
                EditButton()
            }
        }
        .onAppear {
            game.append(CodeBreaker(name: "Mastermind",pegChoices: [.red, .blue, .green, .yellow]))
            game.append(CodeBreaker(name: "Earth Tone",pegChoices: [.orange, .brown, .black, .yellow, .green]))
            game.append(CodeBreaker(name: "Undersea",pegChoices: [.blue, .indigo, .cyan, ]))
        }
    }
}

#Preview {
    GameChooser()
}
