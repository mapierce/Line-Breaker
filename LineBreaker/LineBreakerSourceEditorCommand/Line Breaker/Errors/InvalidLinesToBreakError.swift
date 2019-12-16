//
//  InvalidLinesToBreakError.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

struct InvalidLinesToBreakError: Error {

    let code = 0
    let localizedDescription = "LineBreaker can't find anything to break"

}

