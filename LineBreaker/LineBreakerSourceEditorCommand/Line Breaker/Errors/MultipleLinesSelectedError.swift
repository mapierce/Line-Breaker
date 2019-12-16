//
//  MultipleLinesSelectedError.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

struct MultipleLinesSelectedError: Error {

    let code = 0
    let localizedDescription = "LineBreaker can only work with one line selected"

}
