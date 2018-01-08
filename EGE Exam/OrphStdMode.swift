//
//  OrphStdMode.swift
//  EGE Exam
//
//  Created by Розалия Амирова on 20.07.17.
//  Copyright © 2017 Розалия Амирова. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class OrphStdMode: UIViewController {
    
    @IBOutlet weak var word1: UIButton!
    @IBOutlet weak var word2: UIButton!
    
    @IBOutlet weak var counter: UILabel!
    
    let totalNumberOfQuestions = 10
    var rightWords = [String]()
    var wrongWords = [String]()
    //    var lineFields = [String]()
    var rightResults = [String]()
    var wrongResults = [String]()
    
    var n = 0
    var randIndex = 0
    var rightCount = 0
    var totalCount = 0
    var wordTapped = ""
    var wordUntapped = ""
    var answer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let db = try Connection("\(path)/EGE_DB.sqlite3")
            
            let grammar = Table("Grammar_Words")
            let startPartColumn = Expression<String>("start_part_word")
            let endPartColumn = Expression<String>("end_part_word")
            let rightLetterColumn = Expression<String>("right_letter")
            let wordId = Expression<Int>("word_id")
            
            let totalWordInTable: Int = try db.scalar(grammar.count)
            
            for _ in 0...totalNumberOfQuestions - 1 {
                let wordNumber = Int(arc4random_uniform(UInt32(totalWordInTable)))
                let startPart = try db.pluck(grammar.filter(wordId == (wordNumber % totalWordInTable) + 1))![startPartColumn]
                let endPart = try db.pluck(grammar.filter(wordId == (wordNumber % totalWordInTable) + 1))![endPartColumn]
                let rightLetter = try db.pluck(grammar.filter(wordId == (wordNumber % totalWordInTable) + 1))![rightLetterColumn]
                var wrongLetter = ""
                
                switch rightLetter {
                case "а":
                    wrongLetter = "о"
                case "о":
                    wrongLetter = "а"
                case "и":
                    wrongLetter = "е"
                case "е":
                    wrongLetter = "и"
                case "ы":
                    wrongLetter = "и"
                default:
                    wrongLetter = ""
                }
                rightWords.append(startPart + rightLetter + endPart)
                wrongWords.append(startPart + wrongLetter + endPart)
            }
        } catch {
            print("Error while connection to Database and reading words")
        }
        print(rightWords)
        print(wrongWords)
        nextWord()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func word1Tapped(_ sender: Any) {
        if randIndex == 0 {
            //первое слово нажато правильно
            self.view.backgroundColor = UIColor.green
            rightResults.append(word1.currentTitle!)
            answer = true
            rightCount += 1
        } else if randIndex == 1 {
            //первое слово нажато неправильно
            self.view.backgroundColor = UIColor.red
            answer = false
            wrongResults.append(word1.currentTitle!)
        }
        wordTapped = word1.currentTitle!
        wordUntapped = word2.currentTitle!
        nextWord()
    }
    
    @IBAction func word2Tapped(_ sender: Any) {
        if randIndex == 1 {
            //второе слово нажато правильно
            self.view.backgroundColor = UIColor.green
            answer = true
            rightResults.append(word2.currentTitle!)
            rightCount += 1
        } else if randIndex == 0 {
            //второе слово нажато неправильно
            answer = false
            self.view.backgroundColor = UIColor.red
            wrongResults.append(word2.currentTitle!)
        }
        wordTapped = word2.currentTitle!
        wordUntapped = word1.currentTitle!
        nextWord()
    }
    
    func nextWord() {
        totalCount += 1
        counter.text = String(rightCount)
        if totalCount > totalNumberOfQuestions {
            performSegue(withIdentifier: "OrphToResults", sender: nil)
        }
        performSegue(withIdentifier: "OrphStdRightWrong", sender: nil)

        randIndex = Int(arc4random()) % 2
        if randIndex == 0 {
            word1.setTitle(rightWords[n], for: .normal)
            word2.setTitle(wrongWords[n], for: .normal)
        } else {
            word2.setTitle(rightWords[n], for: .normal)
            word1.setTitle(wrongWords[n], for: .normal)
        }
        n = (n + 1) % totalNumberOfQuestions
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrphToResults" {
            let results = segue.destination as! OrphStdModeResults
            results.setResults(right: rightResults, wrong: wrongResults)
        }
        if segue.identifier == "OrphStdRightWrong" {
            let results = segue.destination as! OrphStdRightWrong
            results.setResults(tapped: wordTapped, untapped: wordUntapped, right: answer)
        }
    }
    
}

