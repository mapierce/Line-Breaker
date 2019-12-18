//
//  LineBreakerFactory.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

protocol LineBreakerFactory {

    func getLineBreaker(from codeString: String) -> LineBreakerProtocol?
    
}
