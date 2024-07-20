//
//  WinModel.swift
//  WordtleGame
//
//  Created by oscar alvarez on 7/19/24.
//

import Foundation
import SwiftUI

struct winStatModel: Codable{
    var winCount: Int // number of total wins + index of arrays below
    var letterCount: [Int] // game mode played in
    var rowCount: [Int] // number of rows needed before guessing word
    var completionTime: Int // How long it took to complete
}
