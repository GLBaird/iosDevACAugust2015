//: Playground - noun: a place where people can play

import Foundation

class Person {
    
    var surname = "Person"
    var forename = "New"
    var age = 0
    var joinDate = NSDate()
    
    init(surname:String, forename:String, age:Int) {
        self.surname = surname
        self.forename = forename
        self.age = age
        
        println("Person created "+self.getFullName())
    }
    
    func getFullName() -> String {
        return forename + " " + surname
    }
    
}

class WorkingPerson: Person {
    var postion = "training"
}


var myPerson = Person(surname: "Baird", forename: "Leon", age: 40)
myPerson.getFullName()

var person2 = Person(surname: "Pie", forename: "Bob", age: 400)


person2.getFullName()
person2.age
myPerson.age

var professional = WorkingPerson(surname: "Evil", forename: "Doctor", age: 50)
professional.getFullName()
