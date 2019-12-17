//
//  String+Extensions.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

extension String {

    func firstIntIndex(of element: Character) -> Int? {
        guard let firstIndex = firstIndex(of: element) else { return nil }
        return distance(from: startIndex, to: firstIndex)
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
        guard 0..<count + 1 ~= range.lowerBound && 0..<count + 1 ~= range.upperBound else { return "" }
        let start = index(startIndex, offsetBy: range.startIndex)
        let end = index(startIndex, offsetBy: range.startIndex + range.count)
        return String(self[start..<end])
    }
    
    func getLeadingSpaceCount() -> Int {
        var spaceCount = 0
        for char in self {
            guard char == " " else { break }
            spaceCount += 1
        }
        return spaceCount
    }
    
    func matchCounts(of first: Character, with second: Character) -> Bool {
        return self.filter { $0 == first }.count == self.filter { $0 == second }.count
    }
    
    func indicesOfString(_ searchString: String) -> [Int] {
        var indices: [Int] = []
        var searchStartIndex = startIndex
        while searchStartIndex < endIndex, let index = self[searchStartIndex..<endIndex].range(of: searchString) {
            indices.append(distance(from: startIndex, to: index.lowerBound))
            searchStartIndex = index.upperBound
        }
        return indices
    }

}
