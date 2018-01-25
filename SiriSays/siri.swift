//
//  siri.swift
//  SimonSays
//
//  Created by Tom Dobson on 1/23/18.
//  Copyright © 2018 Dobson Studios. All rights reserved.
//

import Foundation
import AVFoundation

enum SiriGreetings : String {
    case welcome = "Lets Play Siri Says"
    case pressStartGame = "Care to try yourluck? Press Start"
    case playAgain = "Would you like to Play Again"
}

enum SiriPlayerCall : String{
    case p1 = "Player 1. Your Turn"
    case p2 = "Player 2. Your are Up"
}

enum SiriCongratz : String {
    case wellDone = "Nicely Done"
    case imImpressed = "Wow. You are so good"
    case youAreOnFire = "You are on Fire!"
    case holyCow = "Holy Cow"
    case unstoppable = "You are Unstoppable!"
    case justQuit = "You should just quit while you can"
}

class Siri {
    
    let greetings : [String] = [
        "Lets Play Siri Says",
        "Care to try yourluck? Press Start",
        "Would you like to Play Again"
    ]
    let player1Calls : [String] = [
        "Player 1. You are Turn",
        "Player 1. You are Up",
        "Lets Do it Player 1",
        "Player 1, I bet you can do better.",
        "Come on player 1, Show me What you got."
    ]
    
    let player2Calls : [String] = [
        "Player 2. You are Turn",
        "Player 2. You are Up",
        "Lets Do it Player 2",
        "Player 2, I bet you can do better.",
        "Come on player 2, Show me What you got."
    ]
    
    let congratz : [String] = [
        "Nicely Done",
        "Wow. You are so good",
        "You are on Fire!",
        "Holy Cow",
        "You are Unstoppable!",
        "Wow! How did you do that.",
        "Your opponent is scared"
    ]
    
    let colors : [String] = [
        "Green",
        "Red",
        "Yellow",
        "Purple"
    ]
    
    let player1Win : [String] = [
        "Player 1, you are the beez kneez",
        "Yay! Player 1 wins",
        "Sorry Player 2, you lose",
        "Another win for Player 1",
        "Congratz Player 1. You win a pat on the back"
    ]
    
    let player2Win : [String] = [
        "Player 2, you are the beez kneez",
        "Yay! Player 2 wins",
        "Sorry Player 1, you lose",
        "Another win for Player 2",
        "Congratz Player 2. You win a pat on the back"
    ]
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    func siriSpeak(theText: String) {
        myUtterance = AVSpeechUtterance(string: theText)
        myUtterance.rate = 0.5
        synth.speak(myUtterance)
    }

}
