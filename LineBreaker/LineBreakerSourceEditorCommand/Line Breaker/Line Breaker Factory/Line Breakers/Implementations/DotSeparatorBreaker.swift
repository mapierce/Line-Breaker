//
//  DotSeparatorBreaker.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

struct DotSeparatorBreaker: LineBreakerProtocol {

    private struct Constants {

        static let openBracket: Character = "("
        static let closedBracket: Character = ")"
        static let openCurly: Character = "{"
        static let closedCurly: Character = "}"
        static let dot: Character = "."
        static let newLine = "\n"
        static let tabSpaceCount = 4

    }

    // MARK: - LineBreaker methods
    
    func breakLine(_ line: String) -> String? {
        let dotIndexes = line
            .enumerated()
            .compactMap { $0.element == Constants.dot ? $0.offset : nil }
            .filter { line[0..<$0].matchCounts(of: Constants.openBracket, with: Constants.closedBracket) &&
                line[0..<$0].matchCounts(of: Constants.openCurly, with: Constants.closedCurly) }
            .map { $0 - 1 }
        let splitString = line.split(at: dotIndexes)
        let spaceString = String(repeating: " ", count: Constants.tabSpaceCount + line.getLeadingSpaceCount())
        return splitString[0] +
            Constants.newLine +
            splitString[1..<splitString.count - 1].map { spaceString + $0 + Constants.newLine }.joined() +
            spaceString +
            splitString[splitString.count - 1]
    }

}
