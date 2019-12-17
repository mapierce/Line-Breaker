//
//  BooleanBreaker.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

struct BooleanBreaker: LineBreakerProtocol {
    
    private struct Constants {
        
        static let and = "&&"
        static let or = "||"
        static let openBracket: Character = "("
        static let closedBracket: Character = ")"
        static let newLine = "\n"
        
    }

    // MARK: - LineBreaker methods

    func breakLine(_ line: String) -> String? {
        let indexes = (line.indicesOfString(Constants.and) + line.indicesOfString(Constants.or))
            .filter { line[0..<$0].matchCounts(of: Constants.openBracket, with: Constants.closedBracket) }.map { $0 + 1 }
        var splitString = line.split(at: indexes)
        splitString = [splitString[0]] + splitString[1...].map { $0.trimmingCharacters(in: .whitespaces) }
        let spaceString = String(repeating: " ", count: 4 + line.getLeadingSpaceCount())
        return splitString[0] +
            Constants.newLine +
            splitString[1..<splitString.count - 1].map { spaceString + $0 + Constants.newLine }.joined() +
            spaceString +
            splitString[splitString.count - 1]
    }
    
}
