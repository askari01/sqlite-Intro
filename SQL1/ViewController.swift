//
//  ViewController.swift
//  SQL1
//
//  Created by Syed Askari on 8/24/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DBUtil.sharedInstance.addStudent(name: "ASAD")
        DBUtil.sharedInstance.addStudent(name: "AIZAZ")
        DBUtil.sharedInstance.addStudent(name: "AZEEZ")
        
        var row = DBUtil.sharedInstance.getById(id: 1)
        print (row?.get(DBUtil.sharedInstance.name))
        DBUtil.sharedInstance.delById(id: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

