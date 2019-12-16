//
//  String+Extensions.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

extension String {

    func firstIntIndex(of element: Character) -> Int {
        guard let firstIndex = firstIndex(of: element) else { return -1 }
        return distance(from: startIndex, to: firstIndex)
    }

    func lastIntIndex(of element: Character) -> Int {
        guard let lastIndex = lastIndex(of: element) else { return -1 }
        return distance(from: startIndex, to: lastIndex)
    }

    func split(at indexes: [Int]) -> [String] {
        let updatedIndexes = indexes + [count - 1]
        return updatedIndexes.enumerated().map { (offset: Int, endIndex: Int) -> String in
            let startIndex = offset == 0 ? 0 : indexes[offset - 1] + 1
            let substring = self[index(self.startIndex, offsetBy: startIndex)...index(self.startIndex, offsetBy: endIndex)]
            return String(substring)
        }
    }

    subscript(range: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: range.startIndex)
        let end = index(startIndex, offsetBy: range.startIndex + range.count)
        return String(self[start..<end])
    }

}
