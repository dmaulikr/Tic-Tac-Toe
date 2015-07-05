//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Rohan Daruwala on 7/1/15.
//  Copyright © 2015 Rohan Daruwala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var boardImg1: UIImageView!
    @IBOutlet var boardImg2: UIImageView!
    @IBOutlet var boardImg3: UIImageView!
    @IBOutlet var boardImg4: UIImageView!
    @IBOutlet var boardImg5: UIImageView!
    @IBOutlet var boardImg6: UIImageView!
    @IBOutlet var boardImg7: UIImageView!
    @IBOutlet var boardImg8: UIImageView!
    @IBOutlet var boardImg9: UIImageView!
    
    var boardImageLocation : [UIImageView]!
    
    @IBOutlet var boardB1: UITapGestureRecognizer!
    @IBOutlet var boardB2: UITapGestureRecognizer!
    @IBOutlet var boardB3: UITapGestureRecognizer!
    @IBOutlet var boardB4: UITapGestureRecognizer!
    @IBOutlet var boardB5: UITapGestureRecognizer!
    @IBOutlet var boardB6: UITapGestureRecognizer!
    @IBOutlet var boardB7: UITapGestureRecognizer!
    @IBOutlet var boardB8: UITapGestureRecognizer!
    @IBOutlet var boardB9: UITapGestureRecognizer!
    
    @IBOutlet var xImageDrag: UIImageView!
    @IBOutlet var yImageDrag: UIImageView!
    
    
    @IBOutlet var singlePlayerSwitch: UISwitch!
    
    @IBOutlet var xGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet var yGestureRecognizer: UIPanGestureRecognizer!
    
    var isDraggin = false
    
    var xTurn = true
    let tapRec = UITapGestureRecognizer()
    var AIEnabled = true
    
    var originalXLocation:CGPoint!
    var originalOLocation:CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardImg1.userInteractionEnabled = true
        boardImg2.userInteractionEnabled = true
        boardImg3.userInteractionEnabled = true
        boardImg4.userInteractionEnabled = true
        boardImg5.userInteractionEnabled = true
        boardImg6.userInteractionEnabled = true
        boardImg7.userInteractionEnabled = true
        boardImg8.userInteractionEnabled = true
        boardImg9.userInteractionEnabled = true
        xImageDrag.userInteractionEnabled = true
        yImageDrag.userInteractionEnabled = true
        singlePlayerSwitch.setOn(true, animated: false)
        
        boardImageLocation = [boardImg1, boardImg2, boardImg3, boardImg4, boardImg5, boardImg6, boardImg7, boardImg8, boardImg9]
        
        originalXLocation = xImageDrag.center
        originalOLocation = yImageDrag.center
    }
    
    /**
    A function that checks if three given spaces have existing images that match
    **/
    func checkForMatch(checkOne: UIImageView, checkTwo: UIImageView, checkThree: UIImageView) -> Bool{
        if(checkOne.image != nil && checkTwo.image != nil && checkThree.image != nil){
            if(checkOne.image == checkTwo.image){
                if(checkTwo.image == checkThree.image){
                    return true
                }
            }
        }
        return false
    }
    /**
    Function that checks all winning combinations and determines if one has happened
    **/
    func checkForWin() -> Bool{
        if(checkForMatch(boardImg1, checkTwo: boardImg2, checkThree: boardImg3)){return true}
        if(checkForMatch(boardImg4, checkTwo: boardImg5, checkThree: boardImg6)){return true}
        if(checkForMatch(boardImg7, checkTwo: boardImg8, checkThree: boardImg9)){return true}
        if(checkForMatch(boardImg1, checkTwo: boardImg4, checkThree: boardImg7)){return true}
        if(checkForMatch(boardImg2, checkTwo: boardImg5, checkThree: boardImg8)){return true}
        if(checkForMatch(boardImg3, checkTwo: boardImg6, checkThree: boardImg9)){return true}
        if(checkForMatch(boardImg1, checkTwo: boardImg5, checkThree: boardImg9)){return true}
        if(checkForMatch(boardImg3, checkTwo: boardImg5, checkThree: boardImg7)){return true}
        
        return false
        
    }
    
    /**
    Function that runs if X has won the game. Displays notificaiton and resets the board
    **/
    
    func xWins(){
        
        let alert = UIAlertController(title: "Winner!", message: "X has won the game!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        resetBoard()
        
    }
    
    /**
    Function that runs if O has won the game. Displays notificaiton and resets the board
    **/
    func oWins(){
        let alert = UIAlertController(title: "Winner!", message: "O has won the game!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        resetBoard()
        
    }
    
    /**
    Function that runs if the AI has won the game. Displays notificaiton and resets the board
    **/
    func AIWins(){
        let alert = UIAlertController(title: "Winner!", message: "The AI has won the game!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        resetBoard()
        
    }
    
    /**
    Function that runs and checks if all spaces on the board have been filled. Runs if winning boards are found
    **/
    func checkForDraw()-> Bool{
        let imageArray = [boardImg1.image, boardImg2.image, boardImg3.image, boardImg4.image, boardImg5.image, boardImg6.image, boardImg7.image, boardImg8.image, boardImg9.image]
        for x in imageArray{
            if( x == nil){
                return false
            }
        }
        
        return true
    }
    
    /**
    Function that runs if the game has ended in a draw. Displays notificaiton and resets the board
    **/
    func drawFunction(){
        let alert = UIAlertController(title: "Draw!", message: "The game has ended in a draw!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        resetBoard()
    }
    
    /**
    Function to reset all images on the board
    **/
    func resetBoard(){
        xTurn = true
        boardImg1.image = nil
        boardImg2.image = nil
        boardImg3.image = nil
        boardImg4.image = nil
        boardImg5.image = nil
        boardImg6.image = nil
        boardImg7.image = nil
        boardImg8.image = nil
        boardImg9.image = nil
    }
    
    /**
    Function to make a move for the AI. If two boxes are filled and a winning move can be made, the AI will make that move. Next, the AI will check if the player can win in the next move. If so, the player will be blocked. If neither case occurs, the AI will place into a random box.
    **/
    func AIMove(){
        if(!isDraggin){
            var nextMove = AICheckForWinningMove(UIImage(named: "tictactoe-O.png")!)
            var done = true
            switch nextMove{
            case 1:
                boardImg3.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 2:
                boardImg2.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 3:
                boardImg1.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 4:
                boardImg6.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 5:
                boardImg5.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 6:
                boardImg4.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 7:
                boardImg9.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 8:
                boardImg8.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 9:
                boardImg7.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 10:
                boardImg7.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 11:
                boardImg4.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 12:
                boardImg1.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 13:
                boardImg8.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 14:
                boardImg2.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 15:
                boardImg5.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 16:
                boardImg9.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 17:
                boardImg6.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 18:
                boardImg3.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 19:
                boardImg9.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 20:
                boardImg5.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 21:
                boardImg1.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 22:
                boardImg7.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 23:
                boardImg5.image = UIImage(named: "tictactoe-O.png")
                done = false
            case 24:
                boardImg3.image = UIImage(named: "tictactoe-O.png")
                done = false
            default:
                done = true
            }
            
            if(done){
                nextMove = AICheckForWinningMove(UIImage(named: "tictactoe-X.png")!)
                switch nextMove{
                case 1:
                    boardImg3.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 2:
                    boardImg2.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 3:
                    boardImg1.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 4:
                    boardImg6.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 5:
                    boardImg5.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 6:
                    boardImg4.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 7:
                    boardImg9.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 8:
                    boardImg8.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 9:
                    boardImg7.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 10:
                    boardImg7.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 11:
                    boardImg4.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 12:
                    boardImg1.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 13:
                    boardImg8.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 14:
                    boardImg2.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 15:
                    boardImg5.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 16:
                    boardImg9.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 17:
                    boardImg6.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 18:
                    boardImg3.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 19:
                    boardImg9.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 20:
                    boardImg5.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 21:
                    boardImg1.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 22:
                    boardImg7.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 23:
                    boardImg5.image = UIImage(named: "tictactoe-O.png")
                    done = false
                case 24:
                    boardImg3.image = UIImage(named: "tictactoe-O.png")
                    done = false
                default:
                    done = true
                }
            }
            if(done){
                let fieldArray = [boardImg1, boardImg2, boardImg3, boardImg4, boardImg5, boardImg6, boardImg7, boardImg8, boardImg9]
                var emptyFields:[UIImageView] = []
                
                for x in fieldArray{
                    if x.image == nil{
                        emptyFields.append(x!)
                    }
                }
                if(emptyFields.count > 0){
                    let randomNumber = Int(arc4random_uniform(UInt32((emptyFields.count))))
                    emptyFields[randomNumber].image = UIImage(named: "tictactoe-O.png")!
                    done = false
                    
                }
            }
            
            
            if(checkForWin()){
                AIWins()
            }
            if(checkForDraw()){
                drawFunction()
            }
            xTurn = true
        }
    }
    
    /**
    Function to check to see if a winning move can be made in the next turn for the given player image
    **/
    func AICheckForWinningMove(image: UIImage) -> Int{
        if(WinChecker(boardImg1, checkTwo: boardImg2, checkThree: boardImg3) && boardImg1.image == image){return 1}
        if(WinChecker(boardImg1, checkTwo: boardImg3, checkThree:  boardImg2) && boardImg1.image == image){return 2}
        if(WinChecker(boardImg2, checkTwo: boardImg3, checkThree:  boardImg1) && boardImg2.image == image){return 3}
        
        if(WinChecker(boardImg4, checkTwo: boardImg5, checkThree:  boardImg6) && boardImg4.image == image){return 4}
        if(WinChecker(boardImg4, checkTwo: boardImg6, checkThree:  boardImg5) && boardImg4.image == image){return 5}
        if(WinChecker(boardImg5, checkTwo: boardImg6, checkThree:  boardImg4) && boardImg5.image == image){return 6}
        
        if(WinChecker(boardImg7, checkTwo: boardImg8, checkThree:  boardImg9) && boardImg7.image == image){return 7}
        if(WinChecker(boardImg7, checkTwo: boardImg9, checkThree:  boardImg8) && boardImg7.image == image){return 8}
        if(WinChecker(boardImg8, checkTwo: boardImg9, checkThree:  boardImg7) && boardImg8.image == image){return 9}
        
        if(WinChecker(boardImg1, checkTwo: boardImg4, checkThree:  boardImg7) && boardImg1.image == image){return 10}
        if(WinChecker(boardImg1, checkTwo: boardImg7, checkThree:  boardImg4) && boardImg1.image == image){return 11}
        if(WinChecker(boardImg4, checkTwo: boardImg7, checkThree:  boardImg1) && boardImg4.image == image){return 12}
        
        if(WinChecker(boardImg2, checkTwo: boardImg5, checkThree:  boardImg8) && boardImg2.image == image){return 13}
        if(WinChecker(boardImg5, checkTwo: boardImg8, checkThree:  boardImg2) && boardImg5.image == image){return 14}
        if(WinChecker(boardImg2, checkTwo: boardImg8, checkThree:  boardImg5) && boardImg2.image == image){return 15}
        
        if(WinChecker(boardImg3, checkTwo: boardImg6, checkThree:  boardImg9) && boardImg3.image == image){return 16}
        if(WinChecker(boardImg3, checkTwo: boardImg9, checkThree:  boardImg6) && boardImg3.image == image){return 17}
        if(WinChecker(boardImg6, checkTwo: boardImg9, checkThree:  boardImg3) && boardImg6.image == image){return 18}
        
        if(WinChecker(boardImg1, checkTwo: boardImg5, checkThree:  boardImg9) && boardImg1.image == image){return 19}
        if(WinChecker(boardImg1, checkTwo: boardImg9, checkThree:  boardImg5) && boardImg1.image == image){return 20}
        if(WinChecker(boardImg5, checkTwo: boardImg9, checkThree:  boardImg1) && boardImg5.image == image){return 21}
        
        if(WinChecker(boardImg3, checkTwo: boardImg5, checkThree:  boardImg7) && boardImg3.image == image){return 22}
        if(WinChecker(boardImg3, checkTwo: boardImg7, checkThree:  boardImg5) && boardImg3.image == image){return 23}
        if(WinChecker(boardImg5, checkTwo: boardImg7, checkThree:  boardImg3) && boardImg5.image == image){return 24}
        
        return -1
    }
    
    /**
    Function to check all the possible winning combinations
    **/
    func WinChecker(checkOne: UIImageView, checkTwo: UIImageView, checkThree: UIImageView) -> Bool{
        if(checkOne.image != nil && checkTwo.image != nil){
            if(checkOne.image == checkTwo.image){
                if(checkThree.image == nil){
                    return true
                }
            }
        }
        return false
    }
    
    /**
    Function that places either an 'X' or 'O' on the tapped button, depending on whose turn it is (Determined by boolean xTurn)
    **/
    @IBAction func onClickAction(sender: UITapGestureRecognizer) {
        switch sender{
        case boardB1:
            if(boardImg1.image == nil){
                if(xTurn){
                    xTurn = false
                    boardImg1.image = UIImage(named: "tictactoe-X.png")
                    if(checkForWin()){xWins()}
                    else{
                        if(checkForDraw()){drawFunction()}
                    }
                    
                }
                else{
                    xTurn = true
                    boardImg1.image = UIImage(named: "tictactoe-O.png")
                    if(checkForWin()){oWins()}
                    
                }
            }
        case boardB2:
            if(boardImg2.image == nil){
                if(xTurn){
                    xTurn = false
                    boardImg2.image = UIImage(named: "tictactoe-X.png")
                    if(checkForWin()){xWins()}
                    else{
                        if(checkForDraw()){drawFunction()}
                    }
                    
                }
                else{
                    xTurn = true
                    boardImg2.image = UIImage(named: "tictactoe-O.png")
                    if(checkForWin()){oWins()}
                    
                }
            }
        case boardB3:
            if(boardImg3.image == nil){
                if(xTurn){
                    xTurn = false
                    boardImg3.image = UIImage(named: "tictactoe-X.png")
                    if(checkForWin()){xWins()}
                    else{
                        if(checkForDraw()){drawFunction()}
                    }
                    
                }
                else{
                    xTurn = true
                    boardImg3.image = UIImage(named: "tictactoe-O.png")
                    if(checkForWin()){oWins()}
                    
                }
            }
        case boardB4:
            if(boardImg4.image == nil){
                if(xTurn){
                    xTurn = false
                    boardImg4.image = UIImage(named: "tictactoe-X.png")
                    if(checkForWin()){xWins()}
                    else{
                        if(checkForDraw()){drawFunction()}
                    }
                    
                }
                else{
                    xTurn = true
                    boardImg4.image = UIImage(named: "tictactoe-O.png")
                    if(checkForWin()){oWins()}
                    
                }
            }
        case boardB5:
            if(boardImg5.image == nil){
                if(xTurn){
                    xTurn = false
                    boardImg5.image = UIImage(named: "tictactoe-X.png")
                    if(checkForWin()){xWins()}
                    else{
                        if(checkForDraw()){drawFunction()}
                    }
                    
                }
                else{
                    xTurn = true
                    boardImg5.image = UIImage(named: "tictactoe-O.png")
                    if(checkForWin()){oWins()}
                    
                }
            }
        case boardB6:
            if(boardImg6.image == nil){
                if(xTurn){
                    xTurn = false
                    boardImg6.image = UIImage(named: "tictactoe-X.png")
                    if(checkForWin()){xWins()}
                    else{
                        if(checkForDraw()){drawFunction()}
                    }
                    
                }
                else{
                    xTurn = true
                    boardImg6.image = UIImage(named: "tictactoe-O.png")
                    if(checkForWin()){oWins()}
                    
                }
            }
        case boardB7:
            if(boardImg7.image == nil){
                if(xTurn){
                    xTurn = false
                    boardImg7.image = UIImage(named: "tictactoe-X.png")
                    if(checkForWin()){xWins()}
                    else{
                        if(checkForDraw()){drawFunction()}
                    }
                    
                }
                else{
                    xTurn = true
                    boardImg7.image = UIImage(named: "tictactoe-O.png")
                    if(checkForWin()){oWins()}
                    
                }
            }
        case boardB8:
            if(boardImg8.image == nil){
                if(xTurn){
                    xTurn = false
                    boardImg8.image = UIImage(named: "tictactoe-X.png")
                    if(checkForWin()){xWins()}
                    else{
                        if(checkForDraw()){drawFunction()}
                    }
                    
                }
                else{
                    xTurn = true
                    boardImg8.image = UIImage(named: "tictactoe-O.png")
                    if(checkForWin()){oWins()}
                    
                }
            }
        case boardB9:
            if(boardImg9.image == nil){
                if(xTurn){
                    xTurn = false
                    boardImg9.image = UIImage(named: "tictactoe-X.png")
                    if(checkForWin()){xWins()}
                    else{
                        if(checkForDraw()){drawFunction()}
                    }
                    
                }
                else{
                    xTurn = true
                    boardImg9.image = UIImage(named: "tictactoe-O.png")
                    if(checkForWin()){oWins()}
                    
                }
            }
            
        default:
            print("ERROR")
        }
        if(AIEnabled && !xTurn){
            AIMove()
        }
    }
    /**
    Function to enable/disable the AI if the switch is toggled on/off
    **/
    @IBAction func onToggleAI(sender: AnyObject) {
        resetBoard()
        AIEnabled = !AIEnabled
        if(AIEnabled){
            singlePlayerSwitch.setOn(true, animated: true)
            let alert = UIAlertController(title: "Singleplayer Mode", message: "AI has been enabled. The game will now reset.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else{
            singlePlayerSwitch.setOn(false, animated: true)
            let alert = UIAlertController(title: "Multiplayer Mode", message: "AI has been disabled. The game will now reset.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    /**
    Function to drag the X-image and drop it onto the board. The function first gets the image to drag, and drags it. When the state has ended, the function checks to see if it is on a location in the board. If it is, the image is changed to an 'X' and the X-image is reset to its home location. Finally, the function checks if AI is enabled. If AIEnabled is true, the AI then performs its move
    **/
    @IBAction func dragButtonAction(sender: UIPanGestureRecognizer) {
        var toDrag: UIImageView!
        let locationCoordinates = sender.locationInView(self.view)
        if sender.state == UIGestureRecognizerState.Ended{
            isDraggin = false
            var inLegit = false
            for imageView in boardImageLocation{
                if (imageView.frame.contains(sender.locationInView(self.view))){
                    if(xTurn){
                        imageView.image = UIImage(named: "tictactoe-X.png")
                        xImageDrag.center = originalXLocation
                        xTurn = false
                        inLegit = true
                        if(checkForWin()){
                            xWins()
                        }
                        if(checkForDraw()){
                            drawFunction()
                        }
                        
                    }
                    
                }
            }
            if(!inLegit){
                xImageDrag.center = originalXLocation
            }
        }
        
        if (xImageDrag.frame.contains(locationCoordinates) || isDraggin){
            isDraggin = true
            toDrag = xImageDrag
            toDrag.center = sender.locationInView(self.view)
        }
        
        if(AIEnabled && !xTurn){
            AIMove()
        }
        
    }
    
    /**
        Function to drag the O-image and drop it onto the board. The function first gets the image to drag, and drags it. When the state has ended, the function checks to see if it is on a location in the board. If it is, the image is changed to an 'O' and the O-image is reset to its home location.
    **/
    @IBAction func dragButtonActionO(sender: UIPanGestureRecognizer) {
        var toDrag: UIImageView!
        let locationCoordinates = sender.locationInView(self.view)
        if sender.state == UIGestureRecognizerState.Ended{
            isDraggin = false
            var inLegit = false
            for imageView in boardImageLocation{
                if (imageView.frame.contains(sender.locationInView(self.view))){
                    if(!xTurn){
                        imageView.image = UIImage(named: "tictactoe-O.png")
                        yImageDrag.center = originalOLocation
                        xTurn = true
                        inLegit = true
                        if(checkForWin()){
                            oWins()
                        }
                        if(checkForDraw()){
                            drawFunction()
                        }
                        
                    }
                    
                }
            }
            if(!inLegit){
                yImageDrag.center = originalOLocation
            }
        }
        
        if (yImageDrag.frame.contains(locationCoordinates) || isDraggin){
            isDraggin = true
            toDrag = yImageDrag
            toDrag.center = sender.locationInView(self.view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

