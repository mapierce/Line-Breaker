//
//  LineBreakerFactoryBase.swift
//  LineBreakerSourceEditorCommand
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Foundation

class LineBreakerFactoryBase: LineBreakerFactory {

    private struct Constants {

        static let funcRegEx = #"(func\s|init)((\s*\w*\<.*\>)|(\s*\w*))(\()([[:ascii:]]*)(\{){1}"#
        static let ifLetRegEx = #"^(\s*)(if let|if var)"#
        static let guardLetRegEx = #"^(\s*)(guard let|guard var)"#
        static let arrayRegEx = #"(.*)(=|return)(\s?)\[((.[^\:^\{]*)(\,+)*)\]"#
        static let dictRegEx = #"(.*)(=|return)(\s?)\[(.*)\:.*(\,|\])"#
        static let ifRegEx = #"(^(?=(\s*if)))(^(?!(if var|if let)).+)"#
        static let guardRegex = #"(^(?=(\s*guard)))(^(?!(guard var|guard let)).+)"#

    }

    func getLineBreaker(from codeString: String) -> LineBreakerProtocol {
        if codeString.range(of: Constants.funcRegEx, options: .regularExpression) != nil {
            return FunctionDefinitionBreaker()
        } else if codeString.range(of: Constants.ifLetRegEx, options: .regularExpression) != nil ||
            codeString.range(of: Constants.guardLetRegEx, options: .regularExpression) != nil {
            return UnwrapBreaker()
        } else if codeString.range(of: Constants.arrayRegEx, options: .regularExpression) != nil ||
            codeString.range(of: Constants.dictRegEx, options: .regularExpression) != nil {
            return CollectionBreaker()
        } else if codeString.range(of: Constants.ifRegEx, options: .regularExpression) != nil ||
            codeString.range(of: Constants.guardRegex, options: .regularExpression) != nil {
            return BooleanBreaker()
        }
        return DotSeparatorBreaker()
    }

}
