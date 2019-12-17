//
//  BooleanBreaker.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

struct BooleanBreaker: LineBreakerProtocol {

    // MARK: - LineBreaker methods

    func breakLine(_ line: String) -> String? {
        let indexes = (line.indicesOfString(StringConstants.and) + line.indicesOfString(StringConstants.or))
            .filter { line[0..<$0].matchCounts(of: StringConstants.openBracket, with: StringConstants.closedBracket) }.map { $0 + 1 }
        var splitString = line.split(at: indexes)
        splitString = [splitString[0]] + splitString[1...].map { $0.trimmingCharacters(in: .whitespaces) }
        let spaceString = String(repeating: " ", count: StringConstants.tabSpaceCount + line.getLeadingSpaceCount())
        return splitString[0] +
            StringConstants.newLine +
            splitString[1..<splitString.count - 1].map { spaceString + $0 + StringConstants.newLine }.joined() +
            spaceString +
            splitString[splitString.count - 1]
    }
    
}
