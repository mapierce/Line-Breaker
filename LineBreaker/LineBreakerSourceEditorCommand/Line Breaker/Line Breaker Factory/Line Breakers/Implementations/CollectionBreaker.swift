//
//  CollectionBreaker.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

struct CollectionBreaker: LineBreakerProtocol {
    
    private struct Constants {
        
        static let equals: Character = "="
        static let openBracket: Character = "("
        static let closedBracket: Character = ")"
        static let openSquareBracket: Character = "["
        static let closedSquareBracket: Character = "]"
        static let comma: Character = ","
        static let quote: Character = "\""
        static let newLine = "\n"
        
    }

    // MARK: - LineBreaker methods

    func breakLine(_ line: String) -> String? {
        let equalsIndex = line.firstIntIndex(of: Constants.equals)
        let arrayBody = line[equalsIndex..<line.count]
        let commaIndexes = arrayBody.enumerated()
            .compactMap { $0.element == Constants.comma ? $0.offset : nil }
            .filter { topLevelCommas(in: arrayBody[0..<$0]) }
            .map { $0 + equalsIndex }
        let openSquareIndex = arrayBody.firstIntIndex(of: Constants.openSquareBracket) + 1
        let splitString = line.split(at: commaIndexes)
        let spaceString = String(repeating: " ", count: openSquareIndex + equalsIndex)
        return splitString[0] +
            Constants.newLine +
            splitString[1..<splitString.count - 1].map { formatString($0, with: spaceString) }.joined() +
            spaceString +
            splitString[splitString.count - 1].trimmingCharacters(in: .whitespaces)
    }
    
    // MARK: - Private functions
    
    private func topLevelCommas(in string: String) -> Bool {
        return string.matchCounts(of: Constants.openBracket, with: Constants.closedBracket) &&
            string.filter { $0 == Constants.quote }.count.isMultiple(of: 2)
    }
    
    private func formatString(_ string: String, with spacing: String) -> String {
        return spacing + string.trimmingCharacters(in: .whitespaces) + Constants.newLine
    }
    
}
