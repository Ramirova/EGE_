//
//  ViewController.swift
//  EGE Exam
//
//  Created by Розалия Амирова on 17.07.17.
//  Copyright © 2017 Розалия Амирова. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        copyDatabaseIfNeeded()
        

//        do {
//            let path = NSSearchPathForDirectoriesInDomains(
//                .documentDirectory, .userDomainMask, true
//                ).first!
//            let db = try Connection("\(path)/EGE_DB.sqlite3")
//
//            let accents = Table("Accent_Words")
//            let right = Expression<String>("right_word")
//
//            for accent in try! db.prepare(accents) {
//                do {
//                    print("\(accent[right])")
//                }
//            }
//
//        } catch {
//
//        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func copyDatabaseIfNeeded() {
        // Move database file from bundle to documents folder
        
        let fileManager = FileManager.default
        
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        
        guard documentsUrl.count != 0 else {
            return // Could not find documents URL
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent("EGE_DB.sqlite3")
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent("EGE_DB.sqlite3")
            
            do {
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
            
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
        
    }
}

