//
//  PassString.swift
//  WordtleGame
//
//  Created by Ali Bashir on 7/6/24.
//

import Foundation

extension String {
    func isValidPass() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^.{6,}$", options: .caseInsensitive)
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
}
