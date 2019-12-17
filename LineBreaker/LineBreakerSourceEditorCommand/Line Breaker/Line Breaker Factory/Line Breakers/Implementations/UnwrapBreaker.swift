//
//  UnwrapBreaker.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

struct UnwrapBreaker: LineBreakerProtocol {

    // MARK: - LineBreaker methods

    func breakLine(_ line: String) -> String? {
        let commaIndexes = line.enumerated()
            .compactMap { $0.element == StringConstants.comma ? $0.offset : nil }
            .filter { line[0..<$0].matchCounts(of: StringConstants.openBracket, with: StringConstants.closedBracket) }
        let splitString = line.split(at: commaIndexes)
        guard splitString.count > 1 else { return nil }
        let spaceString = String(repeating: " ", count: StringConstants.tabSpaceCount + line.getLeadingSpaceCount())
        return splitString[0] +
            StringConstants.newLine +
            splitString[1..<splitString.count - 1].map { spaceString + $0.trimmingCharacters(in: .whitespaces) + StringConstants.newLine }.joined() +
            spaceString +
            splitString[splitString.count - 1].trimmingCharacters(in: .whitespaces)
    }
    
}
