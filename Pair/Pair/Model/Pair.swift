//
//  Pair.swift
//  Pair
//
//  Created by Heli Bavishi on 12/18/20.
//

import Foundation

class Pair: Codable {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}//End of class

extension Pair: Equatable {
    static func == (lhs: Pair, rhs: Pair) -> Bool {
        return lhs.name == rhs.name
    }
}
