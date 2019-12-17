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
        guard let beginningIndex = getStartIndex(from: line) else { return nil }
        let arrayBody = line[beginningIndex..<line.count]
        let commaIndexes = arrayBody.enumerated()
            .compactMap { $0.element == StringConstants.comma ? $0.offset : nil }
            .filter { topLevelCommas(in: arrayBody[0..<$0]) }
            .map { $0 + beginningIndex }
        guard let openSquareIndex = arrayBody.firstIntIndex(of: StringConstants.openSquareBracket) else { return nil }
        let splitString = line.split(at: commaIndexes)
        guard splitString.count > 1 else { return nil }
        let spaceString = String(repeating: " ", count: openSquareIndex + 1 + beginningIndex)
        return splitString[0] +
            StringConstants.newLine +
            splitString[1..<splitString.count - 1].map { formatString($0, with: spaceString) }.joined() +
            spaceString +
            splitString[splitString.count - 1].trimmingCharacters(in: .whitespaces)
    }
    
    // MARK: - Private functions
    
    private func getStartIndex(from line: String) -> Int? {
        if let index = line.firstIntIndex(of: StringConstants.equals) {
            return index
        } else if let range = line.range(of: StringConstants.return) {
            return line.distance(from: line.startIndex, to: range.upperBound)
        } else {
            return nil
        }
    }
    
    private func topLevelCommas(in string: String) -> Bool {
        return string.matchCounts(of: StringConstants.openBracket, with: StringConstants.closedBracket) &&
            string.matchCounts(of: StringConstants.openCurly, with: StringConstants.closedCurly) &&
            string.filter { $0 == StringConstants.quote }.count.isMultiple(of: 2)
    }
    
    private func formatString(_ string: String, with spacing: String) -> String {
        return spacing + string.trimmingCharacters(in: .whitespaces) + StringConstants.newLine
    }
    
}
