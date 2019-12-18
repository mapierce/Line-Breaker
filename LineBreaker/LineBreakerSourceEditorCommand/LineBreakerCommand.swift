//
//  LineBreakerCommand.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation
import XcodeKit

class LineBreakerCommand: NSObject, XCSourceEditorCommand {
    
    let lineBreakerFactory: LineBreakerFactory
    
    // MARK: - Initialization
    
    override init() {
        self.lineBreakerFactory = LineBreakerFactoryBase()
        
        super.init()
    }
    
    // MARK: - XCSourceEditorCommand methods
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) -> Void {
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange,
            let lines = invocation.buffer.lines as? [String] else {
                completionHandler(InvalidSelectionError())
                return
        }
        let start = selection.start.line
        let end = selection.end.line
        let line: String
        if start == end {
            line = lines[start]
        } else {
            assert(lines.count > 1)
            line = lines[start].trimmingCharacters(in: .newlines) +
                lines[start + 1...end].map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.joined()
        }
        guard let lineBreaker = lineBreakerFactory.getLineBreaker(from: line) else {
            completionHandler(InvalidSelectionError())
            return
        }
        guard let brokenLine = lineBreaker.breakLine(line, tabWidth: invocation.buffer.tabWidth) else {
            completionHandler(InvalidLinesToBreakError())
            return
        }
        invocation.buffer.lines.removeObjects(in: NSRange(location: start, length: end - start + 1))
        invocation.buffer.lines.insert(brokenLine, at: selection.start.line)
        completionHandler(nil)
    }
    
}
