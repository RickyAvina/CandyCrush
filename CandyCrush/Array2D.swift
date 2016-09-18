//
//  Array2D.swift
//  CandyCrush
//
//  Created by Maricela Avina on 9/17/16.
//  Copyright © 2016 InternTeam. All rights reserved.
//

import Foundation

struct Array2D<T> {
    let columns : Int
    let rows : Int
    private var array : Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(count: rows*columns, repeatedValue: nil)
    }
    
    subscript(column : Int, row: Int) -> T? {
        get {
            return array[row*columns + column]
        }

        set {
            array[row*columns + column] = newValue
        }
    }
}