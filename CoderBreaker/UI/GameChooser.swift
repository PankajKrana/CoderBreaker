//
//  GameChooser.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 10/03/26.
//

import SwiftUI

struct GameChooser: View {
    // MARK: Data Owned by Me
    @State private var games: [CodeBreaker] = []
    @State private var selection: CodeBreaker? = nil
    
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            gameList
        } detail: {
            detailView
        }
        .navigationSplitViewStyle(.balanced)
        .onAppear {
            games.append(CodeBreaker(name: "Mastermind", pegChoices: [.red, .blue, .green, .yellow]))
            games.append(CodeBreaker(name: "Earth Tone", pegChoices: [.orange, .brown, .black, .yellow, .green]))
            games.append(CodeBreaker(name: "Undersea", pegChoices: [.blue, .indigo, .cyan]))
            selection = games.randomElement()
        }
    }
}

private extension GameChooser {
    var gameList: some View {
        List(selection: $selection) {
            ForEach(games) { game in
                NavigationLink(value: game) {
                    GameSummary(game: game)
                }
                .contextMenu {
                    Button("Delete", systemImage: "minus.circle") {
                        withAnimation {
                            games.removeAll { $0 == game }
                            
                        }
                    }
                }
            }
            .onDelete { offsets in
                games.remove(atOffsets: offsets)
            }
            .onMove { offsets, destination in
                games.move(fromOffsets: offsets, toOffset: destination)
            }
        }
        .onChange(of: games) {
            if let selection, !games.contains(selection) {
                self.selection = nil
            }
            
        }
        .navigationTitle("Code Breaker")
        .listStyle(.plain)
        .toolbar {
            Button("Add Game", systemImage: "plus") {
                withAnimation {
                    let newGame = CodeBreaker(name: "Untitled", pegChoices: [.red, .blue])
                    games.append(newGame)
                    
                }
            }
            EditButton()
        }
    }
    
    @ViewBuilder
    var detailView: some View {
        if let selection {
            CodeBreakerView(game: selection)
                .navigationTitle(selection.name)
                .navigationBarTitleDisplayMode(.inline)
        } else {
            Text("Choose The Game")
        }
    }
}

#Preview {
    GameChooser()
}
