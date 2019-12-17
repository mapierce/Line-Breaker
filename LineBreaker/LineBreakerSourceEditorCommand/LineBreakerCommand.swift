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
            selection.start.line == selection.end.line,
            let line = invocation.buffer.lines[selection.start.line] as? String else {
                completionHandler(MultipleLinesSelectedError())
                return
        }
        let lineBreaker = lineBreakerFactory.getLineBreaker(from: line)
        guard let brokenLine = lineBreaker.breakLine(line) else {
            completionHandler(InvalidLinesToBreakError())
            return
        }
        invocation.buffer.lines.removeObject(at: selection.start.line)
        invocation.buffer.lines.insert(brokenLine, at: selection.start.line)
        completionHandler(nil)
    }
    
}
