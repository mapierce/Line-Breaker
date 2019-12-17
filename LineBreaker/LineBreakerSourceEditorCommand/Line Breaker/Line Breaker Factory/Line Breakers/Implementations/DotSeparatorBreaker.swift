//
//  DotSeparatorBreaker.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

struct DotSeparatorBreaker: LineBreakerProtocol {

    // MARK: - LineBreaker methods
    
    func breakLine(_ line: String) -> String? {
        let dotIndexes = line
            .enumerated()
            .compactMap { $0.element == StringConstants.dot ? $0.offset : nil }
            .filter { line[0..<$0].matchCounts(of: StringConstants.openBracket, with: StringConstants.closedBracket) &&
                line[0..<$0].matchCounts(of: StringConstants.openCurly, with: StringConstants.closedCurly) }
            .map { $0 - 1 }
        let splitString = line.split(at: dotIndexes)
        let spaceString = String(repeating: " ", count: StringConstants.tabSpaceCount + line.getLeadingSpaceCount())
        return splitString[0] +
            StringConstants.newLine +
            splitString[1..<splitString.count - 1].map { spaceString + $0 + StringConstants.newLine }.joined() +
            spaceString +
            splitString[splitString.count - 1]
    }

}
