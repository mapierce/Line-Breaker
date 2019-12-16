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
            .filter { matchCounts(of: Constants.openBracket, with: Constants.closedBracket, in: line[0..<$0]) &&
                matchCounts(of: Constants.openCurly, with: Constants.closedCurly, in: line[0..<$0]) }
            .map { $0 - 1 }
        let splitString = line.split(at: dotIndexes)
        let spaceString = String(repeating: " ", count: Constants.tabSpaceCount + getLeadingSpaceCount(from: line))
        return splitString[0] +
            Constants.newLine +
            splitString[1..<splitString.count - 1].map { spaceString + $0 + Constants.newLine }.joined() +
            spaceString +
            splitString[splitString.count - 1]
    }

    // MARK: - Public methods

    func getLeadingSpaceCount(from line: String) -> Int {
        var spaceCount = 0
        for char in line {
            guard char == " " else { break }
            spaceCount += 1
        }
        return spaceCount
    }

    func matchCounts(of first: Character, with second: Character, in string: String) -> Bool {
        return string.filter { $0 == first }.count == string.filter { $0 == second }.count
    }

}
