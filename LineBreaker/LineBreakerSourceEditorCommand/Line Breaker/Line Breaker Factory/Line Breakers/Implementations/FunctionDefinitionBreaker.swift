//
//  FunctionDefinitionBreaker.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

struct FunctionDefinitionBreaker: LineBreakerProtocol {

    // MARK: - LineBreaker methods

    func breakLine(_ line: String, tabWidth spacesPerTab: Int) -> String? {
        guard let bracketIndexes = getBracketIndexes(from: line),
            let openBracket = line.firstIntIndex(of: StringConstants.openBracket) else { return nil }
        var innerFunction = String(line[bracketIndexes.open...bracketIndexes.close])
        let commaIndexes = getCommaIndexes(from: innerFunction)
        let lines = innerFunction.split(at: commaIndexes)
        guard lines.count > 1 else { return nil }
        innerFunction = lines[0] + StringConstants.newLine + innerFunction.split(at: commaIndexes)[1..<lines.count]
            .map { String(repeating: " ", count: openBracket + 1) + $0.trimmingCharacters(in: .whitespaces) }
            .reduce("") { (current, next) in "\(current)\(next)\(StringConstants.newLine)"}
        innerFunction.removeLast()
        let prefix = line[...line.index(bracketIndexes.open, offsetBy: -1)]
        let suffix = line[line.index(bracketIndexes.close, offsetBy: 1)...]
        return prefix + innerFunction + suffix
    }

    // MARK: - Public methods

    func getBracketIndexes(from funcName: String, offset: (start: Int, end: Int) = (1, -1)) -> (open: String.Index, close: String.Index)? {
        guard let openIndex = funcName.firstIndex(of: StringConstants.openBracket),
            let closeIndex = funcName.lastIndex(of: StringConstants.closedBracket),
            funcName.distance(from: funcName.startIndex, to: closeIndex) + offset.end >= funcName.distance(from: funcName.startIndex, to: openIndex) + offset.start else { return nil }
        return (funcName.index(openIndex, offsetBy: offset.start), funcName.index(closeIndex, offsetBy: offset.end))
    }

    func getCommaIndexes(from innerFunc: String) -> [Int] {
        var currentlyInBrackets = false
        return innerFunc.enumerated().map { item in
            let bracketFound = item.element == StringConstants.openBracket || item.element == StringConstants.closedBracket
            currentlyInBrackets = bracketFound ? item.element == StringConstants.openBracket : currentlyInBrackets
            return item.element == StringConstants.comma && !currentlyInBrackets ? item.offset : nil
        }.compactMap { $0 }
    }

}

