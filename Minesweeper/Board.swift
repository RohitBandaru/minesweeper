//
//  Board.swift
//  Minesweeper
//
//  Created by Rohit Bandaru on 11/28/16.
//  Copyright © 2016 Rohit Bandaru. All rights reserved.
//

import UIKit

class Board{
    var tiles: [[Tile]]
    var boardDimension: Int
    var screenWidth: Int
    var screenHeight: Int
    
    init(dimension: Int, screenWidth: Int, screenHeight: Int){
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        tiles = [[Tile]]()
        self.boardDimension = dimension
        for i in 0 ..< boardDimension{
            var row = [Tile]()
            for j in 0 ..< boardDimension{
                row.append(Tile(row: i, column: j, board: self))
            }
            tiles.append(row)
        }
    }
    
    func revealBoard(){
        for i in 0 ..< boardDimension{
            for j in 0 ..< boardDimension{
                tiles[i][j].tileReveal()
            }

        }
    }

}
