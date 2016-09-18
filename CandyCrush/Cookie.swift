//
//  Cookie.swift
//  CandyCrush
//
//  Created by Maricela Avina on 9/17/16.
//  Copyright © 2016 InternTeam. All rights reserved.
//

import Foundation
import SpriteKit

enum CookieType: Int, CustomStringConvertible {
    case Unknown = 0, Croissant, Cupcake, Danish, Donut, Macaroon, SugarCookie
    
    var description: String {
        return spriteName
    }
    
    var spriteName: String {
        let spriteNames = [
            "Croissant",
            "Cupcake",
            "Danish",
            "Donut",
            "Macaroon",
            "SugarCookie"]
        
        return spriteNames[rawValue - 1]
    }
    
    var highlightedSpriteName: String {
        return spriteName + "-Highlighted"
    }
    
    static func random() -> CookieType {
        return CookieType(rawValue: Int(arc4random_uniform(6)) + 1)!
    }

}


class Cookie : CustomStringConvertible, Hashable {
    var column: Int
    var row: Int
    let cookieType: CookieType
    var sprite: SKSpriteNode?
    
    var hashValue: Int {
            return row*10 + column
    }
    
    var description: String {
        return "type: \(cookieType)\nsquare:(\(column),\(row))"
    }
    
    init(column: Int, row: Int, cookieType: CookieType) {
        self.column = column
        self.row = row
        self.cookieType = cookieType
    }
}

func ==(lhs: Cookie, rhs: Cookie) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}