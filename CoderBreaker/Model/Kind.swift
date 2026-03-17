//
//  Kind.swift
//  CoderBreaker
//
//  Created by Pankaj Kumar Rana on 18/03/26.
//

import Foundation

enum Kind: Equatable, CustomStringConvertible {
    case master(isHidden: Bool)
    case guess
    case attempts([Match])
    case unknown

    // MARK: - Convert enum → string
    var description: String {
        switch self {
        case .master(let isHidden):
            return "master|\(isHidden)"
        case .guess:
            return "guess"
        case .attempts(let matches):
            let values = matches.map { $0.rawValue }.joined(separator: ",")
            return "attempts|\(values)"
        case .unknown:
            return "unknown"
        }
    }

    // MARK: - Non-failable string → enum
    init(string: String) {
        let parts = string.split(separator: "|", maxSplits: 1).map(String.init)
        let type = parts.first ?? "unknown"

        switch type {
        case "master":
            // Use Bool initializer safely, fallback to false
            let isHidden = parts.count == 2 ? Bool(parts[1]) ?? false : false
            self = .master(isHidden: isHidden)
        case "guess":
            self = .guess
        case "attempts":
            let matches: [Match]
            if parts.count == 2 {
                matches = parts[1]
                    .split(separator: ",")
                    .compactMap { Match(rawValue: String($0)) }
            } else {
                matches = []
            }
            self = .attempts(matches)
        default:
            self = .unknown
        }
    }
}
