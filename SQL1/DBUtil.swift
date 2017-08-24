//
//  DBUtil.swift
//  SQL1
//
//  Created by Syed Askari on 8/24/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import Foundation
import SQLite

class DBUtil {
    static var sharedInstance = DBUtil()
    var db: Connection?
    
    let students = Table("Student")
    let id = Expression<Int64>("Id")
    let name = Expression<String>("Name")
    
    init() {
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print (path)
        do {
            db = try Connection("\(path)/test1.sqlite3")
//            try db?.run(students.create(block: {
//                t in
//                    t.column(id)
//                    t.column(name)
//            }))
//            try db?.run(students.drop())
            
            try db?.run(students.create( temporary: false, ifNotExists: true, block: {
                t in
                t.column(id, primaryKey: true)
                t.column(name)
            }))

        } catch _ {
            print ("error connecting with database")
        }
    }
    
    func addStudent(name: String) {
        do {
            try db!.run(students.insert(self.name<-name))
            print ("Insert Successful")
        } catch _ {
            print ("Insert Error")
        }
    }
    
    func getById(id: Int64) ->Row? {
        do {
            let qyery = try students.filter(self.id == id)
            print (qyery.asSQL())
            var data = try db!.pluck(qyery)
            return data
        } catch _ {
            print ("Error get by id: \(id)")
            return nil
        }
    }
    
    func delById(id: Int64) {
        do {
            let qyery = try students.filter(self.id == id)
            print (qyery.asSQL())
            try db!.run(qyery.delete())
        } catch _ {
            print ("Error del by id: \(id)")
        }
    }
}
