//
//  MatchView.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 25/12/25.
//

import SwiftUI


struct MatchMarkerView: View {
    
    var matches: [Match]
    var body: some View {
        HStack {
            VStack {
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            }
            VStack {
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
        }
    }
    
    func matchMarker(peg: Int) -> some View{
        let exactCount: Int = matches.count { $0  == .exact}
        let foundCount: Int = matches.count { $0  != .nomatch}
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2).aspectRatio(1, contentMode: .fit)
        
    }
    
}

enum Match {
    case nomatch
    case exact
    case inexact
}

#Preview {
    MatchMarkerView(matches: [.exact, .inexact, .nomatch])
}
