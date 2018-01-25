//
//  ViewController.swift
//  SimonSays
//
//  Created by Tom Dobson on 1/23/18.
//  Copyright © 2018 Dobson Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var colorButtons: [customBtn]!
    @IBOutlet var playerLabels: [UILabel]!
    @IBOutlet var scoreLabels: [UILabel]!
    @IBOutlet weak var actionBtn: UIButton!
    
    var currentPlayer = 0
    var scores = [0,0]
    let siri = Siri()
    
    var sequenceIndex = 0
    var colorSequence = [Int]()
    var colorsToTap = [Int]()
    
    var gameEnded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortPlayerScoresAndLabels()
        createNewGame()
        siri.siriSpeak(theText: siri.greetings[0])
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameEnded {
            gameEnded = false
            createNewGame()
        }
    }

    func createNewGame() {
        colorSequence.removeAll()
        
        actionBtn.setTitle("Start Game", for: .normal)
        actionBtn.isEnabled = true
    
        for button in colorButtons {
            button.alpha = 0.5
            button.isEnabled = false
        }
        currentPlayer = 0
        scores = [0,0]
        print(currentPlayer)
        playerLabels[currentPlayer].alpha = 1.0
        playerLabels[1].alpha = 0.75
        updateScoreLabes()
    }
    
    func updateScoreLabes() {
        for (index,label) in scoreLabels.enumerated() {
             label.text = "\(scores[index])"
        }
    }
    
    func switchPlayers() {
        playerLabels[currentPlayer].alpha = 0.75
        currentPlayer = currentPlayer == 0 ? 1 : 0
        playerLabels[currentPlayer].alpha = 1.0
        
    }
    
    func addNewColor() {
        let colorseq = colorSequence
        colorSequence.removeAll()
        for i in 0...colorseq.count {
            colorSequence.append(Int(arc4random_uniform(UInt32(4))))
        }
    }
    
    func playSequence() {
        if sequenceIndex < colorSequence.count {
            flashBtn(button: colorButtons[colorSequence[sequenceIndex]])
            sequenceIndex += 1
        } else {
            colorsToTap = colorSequence
            view.isUserInteractionEnabled = true
            actionBtn.setTitle("Tap the Circles", for: .normal)
            for button in colorButtons {
                 button.isEnabled = true
            }
        }
    }
    
    func sayColor(index: Int) {
        siri.siriSpeak(theText: siri.colors[index])
    }
    
    func flashBtn(button: customBtn) {
        sayColor(index: button.tag)
        UIView.animate(withDuration: 1.0, animations: {
            button.alpha = 1.0
            button.alpha = 0.5
        }) { (bool) in
            self.playSequence()
        }
    }
    
    func endGame() {
        if currentPlayer == 0 {
            let message = "Player 2 Wins"
            siri.siriSpeak(theText: siri.player2Win[rng(index: 5)])
            actionBtn.setTitle(message, for: .normal)
            gameEnded = true
        } else {
            let message = "Player 1 Wins"
            siri.siriSpeak(theText: siri.player1Win[rng(index: 5)])
            actionBtn.setTitle(message, for: .normal)
            gameEnded = true
        }

    }

    @IBAction func colorBtnHandler(_ sender: customBtn) {
        print(sender.tag)
        if sender.tag == colorsToTap.removeFirst() {
            
        } else {
            for button in colorButtons {
                button.isEnabled = false
            }
            endGame()
            return
        }
        if colorsToTap.isEmpty {
            for button in colorButtons {
                button.isEnabled = false
            }
            scores[currentPlayer] += 1
            updateScoreLabes()
            switchPlayers()
            if currentPlayer == 0 {
                siri.siriSpeak(theText: siri.congratz[rng(index: 6)])
                siri.siriSpeak(theText: siri.player1Calls[rng(index: 4)])
            } else {
                siri.siriSpeak(theText: siri.congratz[rng(index: 6)])
                siri.siriSpeak(theText: siri.player2Calls[rng(index: 4)])
            }
            actionBtn.setTitle("Next Round", for: .normal)
            actionBtn.isEnabled = true
        }
    }
    
    @IBAction func actionBtnHandler(_ sender: UIButton) {
        sequenceIndex = 0
        actionBtn.setTitle("Memorize", for: .normal)
        actionBtn.isEnabled = false
        view.isUserInteractionEnabled = false
        addNewColor()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.playSequence()
        }
    }

    func sortPlayerScoresAndLabels() {
        playerLabels = playerLabels.sorted() {
            $0.tag < $1.tag
        }
        
        scoreLabels = scoreLabels.sorted() {
            $0.tag < $1.tag
        }
    }
    
    func rng(index: Int) -> Int {
        let randomNumber = Int(arc4random_uniform(UInt32(index)))
        return randomNumber
    }
    
}

