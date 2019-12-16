//
//  IfLetBreaker.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

struct IfLetBreaker: LineBreakerProtocol {
    
    private struct Constants {
        
        static let comma: Character = ","
        static let openBracket: Character = "("
        static let cloedBracket: Character = ")"
        static let tabSpaceCount = 4
        static let newLine = "\n"
        
    }

    // MARK: - LineBreaker methods

    func breakLine(_ line: String) -> String? {
        let commaIndexes = line.enumerated()
            .compactMap { $0.element == Constants.comma ? $0.offset : nil }
            .filter { line[0..<$0].matchCounts(of: Constants.openBracket, with: Constants.cloedBracket) }
        let splitString = line.split(at: commaIndexes)
        let spaceString = String(repeating: " ", count: Constants.tabSpaceCount + line.getLeadingSpaceCount())
        return splitString[0] +
            Constants.newLine +
            splitString[1..<splitString.count - 1].map { spaceString + $0.trimmingCharacters(in: .whitespaces) + Constants.newLine }.joined() +
            spaceString +
            splitString[splitString.count - 1].trimmingCharacters(in: .whitespaces)
    }
    
}
