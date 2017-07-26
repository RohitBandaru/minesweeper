//
//  Tile.swift
//  Minesweeper
//
//  Created by Rohit Bandaru on 11/28/16.
//  Copyright © 2016 Rohit Bandaru. All rights reserved.
//

import UIKit


class Tile: UIButton{
    var isMine: Bool
    var row: Int
    var column: Int
    var board: Board
    var isRevealed: Bool
    var isExpanded: Bool
    init(row:Int, column:Int, board: Board){
        self.row = row
        self.column = column
        self.board = board
        self.isRevealed = false
        self.isExpanded = false
        
        //random number between 0 and 99
        let rand = Int(arc4random()%100)
        let probabilityOfMine = 20
        self.isMine = (rand < probabilityOfMine) ? true : false
        
        let screenWidth = board.screenWidth
        let screenHeight = board.screenHeight
        
        let dimension = board.boardDimension
        let margin = 5
        
        let size = (Int(min(screenWidth, screenHeight)) - (dimension)*margin)/dimension
        
        let x1 = CGFloat((column) * (size+margin) + margin)
        let y1 = CGFloat((row) * (size+margin) + 50)
        let width = CGFloat(size)
        let height = CGFloat(size)
        
        
        let tileFrame = CGRect(x: x1, y: y1, width: width, height: height)
        
        super.init(frame: tileFrame)
        self.backgroundColor = .black
    }
    
    func getNeighbors()->[Tile]{
        var neighbors = [Tile]()

        appendTile(neighbors: &neighbors, tileRow: row-1, tileColumn: column-1)
        appendTile(neighbors: &neighbors, tileRow: row-1, tileColumn: column)
        appendTile(neighbors: &neighbors, tileRow: row-1, tileColumn: column+1)
        appendTile(neighbors: &neighbors, tileRow: row, tileColumn: column-1)
        appendTile(neighbors: &neighbors, tileRow: row, tileColumn: column+1)
        appendTile(neighbors: &neighbors, tileRow: row+1, tileColumn: column-1)
        appendTile(neighbors: &neighbors, tileRow: row+1, tileColumn: column)
        appendTile(neighbors: &neighbors, tileRow: row+1, tileColumn: column+1)
        
        return neighbors
    }
    
    func appendTile(neighbors:inout [Tile], tileRow:Int, tileColumn:Int){
        if((tileRow >= 0) && (tileColumn >= 0) && (tileRow < board.boardDimension) && (tileColumn < board.boardDimension)){
            neighbors.append(board.tiles[tileRow][tileColumn])
        }
    }
    
    func numberOfNeighboringMines()->Int{
        var numberOfNeighboringMines = 0
        for tile in self.getNeighbors() {
            if(tile.isMine){
                numberOfNeighboringMines += 1
            }
        }
        return numberOfNeighboringMines
    }
    
    
    func tilePressed(){
        self.isRevealed = true
        if(isMine){
            //game over
            print("MINE!!!")
            self.backgroundColor = .red
            board.revealBoard()
        }
        else if(self.numberOfNeighboringMines() != 0){
            self.tileReveal()
            }
        else if(self.numberOfNeighboringMines() == 0){
            self.backgroundColor = .blue
            for neighbor in self.getNeighbors(){
                if(!(neighbor.isMine)){
                    neighbor.tileReveal()
                    let numberOfNeighborMines = neighbor.numberOfNeighboringMines()
                    if (numberOfNeighborMines == 0){
                        //if tile has no neighboring mines expand
                        expand(tile: neighbor)
                    }
                }
            }
        }
    }
    
    func tileReveal(){
        if(self.isMine){
            self.backgroundColor = .red
        }
        else{
            self.isRevealed = true;
            let numberOfNeighbors = self.numberOfNeighboringMines()
            self.backgroundColor = .blue
            if(numberOfNeighbors != 0){
                self.setTitle(String(numberOfNeighbors), for: UIControlState.normal)
            }
            
        }
    }

    func expand(tile: Tile){
        
        tile.tileReveal()
    
        var queue = TileQueue();
        queue.enqueue(tile: tile)
        
        // BFS
        while(!queue.isEmpty){
            let t : Tile = queue.dequeue()!
            t.isExpanded = true
            for neighbor in t.getNeighbors(){
                if(!(neighbor.isMine)){
                    neighbor.tileReveal()
                    if (neighbor.numberOfNeighboringMines() == 0 && !neighbor.isExpanded){
                        queue.enqueue(tile: neighbor)
                    }
                }
            }
        }
    }
    
    public struct TileQueue {
        private var array = [Tile]()

        public var isEmpty: Bool {
            return array.isEmpty
        }
        
        public mutating func enqueue(tile: Tile) {
            array.append(tile)
        }
        
        public mutating func dequeue() -> Tile? {
            if isEmpty {
                return nil
            } else {
                return array.removeFirst()
            }
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
