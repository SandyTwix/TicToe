//
//  ViewController.swift
//  XO
//
//  Created by SandyTwix on 17.11.2021.
//  Copyright © 2021 SandyTwix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Turn {
        case O
        case X
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    
    var firstTurn = Turn.X
    var currentTurn = Turn.X
    var desk = [UIButton]()
    
    var xScore = 0
    var oScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesk()
    }
    
    func initDesk(){
        desk.append(a1)
        desk.append(a2)
        desk.append(a3)
        desk.append(b1)
        desk.append(b2)
        desk.append(b3)
        desk.append(c1)
        desk.append(c2)
        desk.append(c3)
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        addToDesk(sender)
        
        if checkForVictory("X"){
            xScore += 1
            xLabel.text = String(xScore)
            resultAlert(title: "X Победил!")
        }
        
        if checkForVictory("O"){
            oScore += 1
            yLabel.text = String(oScore)
            resultAlert(title: "O Победил!")
        }
        
        if(fullDesk()){
            resultAlert(title: "Игра закончена!")
        }
    }
    
    func checkForVictory(_ s: String) -> Bool{
        // Horizontal Victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s){
            return true
        }
        
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s){
            return true
        }
        
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s){
            return true
        }
        
        // Vertical Victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s){
            return true
        }
        
        if thisSymbol(a2, s) && thisSymbol(a2, s) && thisSymbol(c2, s){
            return true
        }
        
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s){
            return true
        }
        
        // Diagonal Victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s){
            return true
        }
        
        if thisSymbol(a3, s) && thisSymbol(a2, s) && thisSymbol(c1, s){
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool{
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String){
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Новая игра", style: .default, handler: { (_) in
            self.resetDesk()
        }))
        self.present(ac, animated: true)
    }
    
    func resetDesk(){
        for button in desk{
            
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.O {
            firstTurn = Turn.X
            turnLabel.text = "X"
        }
        else if firstTurn == Turn.X {
            firstTurn = Turn.O
            turnLabel.text = "O"
        }
        currentTurn = firstTurn
    }
    
    func fullDesk() -> Bool {
        for button in desk
        {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToDesk(_ sender: UIButton) {
        if(sender.title(for: .normal) == nil)
        {
            if(currentTurn == Turn.O){
                sender.setTitle("O", for: .normal)
                currentTurn = Turn.X
                turnLabel.text = "X"
            }
            else if(currentTurn == Turn.X){
                sender.setTitle("X", for: .normal)
                currentTurn = Turn.O
                turnLabel.text = "O"
            }
            sender.isEnabled = false
        }
    }
}

