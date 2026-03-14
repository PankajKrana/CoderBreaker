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
    
    @State private var showGameEditor: Bool = false
    @State private var gameToEdit: CodeBreaker?
    
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
                    editButton(for: game) // editing a game
                    Button("Delete", systemImage: "minus.circle") {
                        withAnimation {
                            games.removeAll { $0 == game }
                            
                        }
                    }
                }
                .swipeActions(edge: .leading) {
                    editButton(for: game).tint(.accentColor)
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
            addButton
            EditButton() // Editing the List of game
        }
    }
    
    
    func editButton(for game: CodeBreaker) -> some View {
        Button("Edit", systemImage: "pencil") {
            gameToEdit = game
        }
    }
    
    var addButton: some View {
        Button("Add Game", systemImage: "plus") {
            gameToEdit = CodeBreaker(name: "Untitled", pegChoices: [.red, .blue])
            showGameEditor = true
        }
        .onChange(of: gameToEdit) {
            showGameEditor = gameToEdit != nil
        }
        .sheet(isPresented: $showGameEditor, onDismiss: { gameToEdit = nil }) {
            gameEdit
        }
        
    }
    
    @ViewBuilder
    var gameEdit: some View {
        if let gameToEdit {
            let copyOfGameToEdit = CodeBreaker(name: gameToEdit.name, pegChoices: gameToEdit.pegChoices)
            GameEditor(game: copyOfGameToEdit){
                if let index = games.firstIndex(of: gameToEdit){
                    games[index] = copyOfGameToEdit
                } else {
                    games.insert(gameToEdit, at: 0)
                }
            }
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
