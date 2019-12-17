//
//  CollectionBreaker.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

struct CollectionBreaker: LineBreakerProtocol {

    // MARK: - LineBreaker methods

    func breakLine(_ line: String) -> String? {
        let equalsIndex = line.firstIntIndex(of: StringConstants.equals)
        let arrayBody = line[equalsIndex..<line.count]
        let commaIndexes = arrayBody.enumerated()
            .compactMap { $0.element == StringConstants.comma ? $0.offset : nil }
            .filter { topLevelCommas(in: arrayBody[0..<$0]) }
            .map { $0 + equalsIndex }
        let openSquareIndex = arrayBody.firstIntIndex(of: StringConstants.openSquareBracket) + 1
        let splitString = line.split(at: commaIndexes)
        let spaceString = String(repeating: " ", count: openSquareIndex + equalsIndex)
        return splitString[0] +
            StringConstants.newLine +
            splitString[1..<splitString.count - 1].map { formatString($0, with: spaceString) }.joined() +
            spaceString +
            splitString[splitString.count - 1].trimmingCharacters(in: .whitespaces)
    }
    
    // MARK: - Private functions
    
    private func topLevelCommas(in string: String) -> Bool {
        return string.matchCounts(of: StringConstants.openBracket, with: StringConstants.closedBracket) &&
            string.filter { $0 == StringConstants.quote }.count.isMultiple(of: 2)
    }
    
    private func formatString(_ string: String, with spacing: String) -> String {
        return spacing + string.trimmingCharacters(in: .whitespaces) + StringConstants.newLine
    }
    
}
