//
//  GameViewController.swift
//  Minesweeper
//
//  Created by Rohit Bandaru on 11/28/16.
//  Copyright © 2016 Rohit Bandaru. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    let easyButton = UIButton(frame: CGRect(x: 0, y: 510, width: 300, height: 30))
    let mediumButton = UIButton(frame: CGRect(x: 0, y: 550, width: 300, height: 30))
    let hardButton = UIButton(frame: CGRect(x: 0, y: 590, width: 300, height: 30))
    let clearButton = UIButton(frame: CGRect(x: 0, y: 470, width: 300, height: 30))
    
    var currentBoard = Board(dimension: 1, screenWidth: 0, screenHeight: 0)
    var screenWidth = 10
    var screenHeight = 10
    var currentDifficulty = "Medium"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        screenWidth = Int(self.view.frame.size.width)
        screenHeight = Int(self.view.frame.size.height)
    
        // Do any additional setup after loading the view, typically from a nib.
        
        initializeMediumBoard()
    
        easyButton.setTitle("Easy", for: UIControlState.normal)
        easyButton.center.x = self.view.center.x
        easyButton.setTitleColor(.black, for: .normal)
        view.addSubview(easyButton)
        easyButton.addTarget(self, action: #selector(initializeEasyBoard), for: .touchUpInside)
        
        
        mediumButton.setTitle("Medium", for: UIControlState.normal)
        mediumButton.center.x = self.view.center.x
        mediumButton.setTitleColor(.black, for: .normal)
        view.addSubview(mediumButton)
        mediumButton.addTarget(self, action: #selector(initializeMediumBoard), for: .touchUpInside)
        
        hardButton.setTitle("Hard", for: UIControlState.normal)
        hardButton.center.x = self.view.center.x
        hardButton.setTitleColor(.black, for: .normal)
        view.addSubview(hardButton)
        hardButton.addTarget(self, action: #selector(initializeHardBoard), for: .touchUpInside)
        
        clearButton.setTitle("Reset Board", for: UIControlState.normal)
        clearButton.center.x = self.view.center.x
        clearButton.setTitleColor(.black, for: .normal)
        view.addSubview(clearButton)
        clearButton.addTarget(self, action: #selector(resetBoard), for: .touchUpInside)
    }
    
    func resetBoard(){
        clearBoard()
        if (currentDifficulty == "Easy"){
            initializeEasyBoard()
        }
        else if (currentDifficulty == "Medium"){
            initializeMediumBoard()
        }
        else if (currentDifficulty == "Hard"){
            initializeHardBoard()
        }
    }
    
    func clearBoard(){
        for i in 0 ..< currentBoard.boardDimension{
            for j in 0 ..< currentBoard.boardDimension{
                let tile = currentBoard.tiles[i][j]
                tile.removeFromSuperview()
            }
        }
        print("clear")
        
    }
    
    func initializeBoard(dimension: Int, screenwidth:Int, screenheight:Int)->Board{
        clearBoard()
        let board = Board(dimension: dimension, screenWidth: screenwidth, screenHeight: screenheight)
        let tiles = board.tiles
        for row in tiles{
            for tile in row{
                tile.addTarget(tile, action: #selector(tile.tilePressed), for: .touchUpInside)
                view.addSubview(tile)
            }
        }
        currentBoard = board
        return board
    }
    
    func initializeEasyBoard(){
        currentBoard = initializeBoard(dimension: 4, screenwidth:screenWidth, screenheight:screenHeight )
        currentDifficulty = "Easy"
    }
    func initializeMediumBoard(){
        currentBoard = initializeBoard(dimension: 8, screenwidth:screenWidth, screenheight:screenHeight )
        currentDifficulty = "Medium"
    }
    func initializeHardBoard(){
        currentBoard = initializeBoard(dimension: 12, screenwidth:screenWidth, screenheight:screenHeight )
        currentDifficulty = "Hard"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

