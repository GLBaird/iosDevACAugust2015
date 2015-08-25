//: Playground - noun: a place where people can play

import Foundation

// constant

let myConstant = "Hi There"

myConstant

// myConstant = "Another thing"  throws error!

// Statements

// if BOOL { code } else { code }

var score = 200

if score > 150 {
    println("You have passed!")
} else {
    println("You have failed!")
}

var grade = "fail"

if score >= 150 {
    grade = "distinction"
} else if score > 100 {
    grade = "merit"
} else if score >= 50 {
    grade = "pass"
}


println("You have scored: \(grade)")

var username = "Mary"

switch username {
    case "Leon":
        println("Hi there Leon")
    
    case "Mary":
        println("Hi Mary, how is the lamb?")
    
    case "Bob":
        println("Sorry Bob, we're closed today!")
    
    default:
        println("I do not know who you are!")
}

// Ternary

let result = score > 100 ? "Pass" : "Fail"


// functions

func sayHello() {
    println("****************")
    println("Hi there!!")
    println("****************")
}

sayHello()

func calculateTheMeaningofLife() -> Int {
    // 7 million years worth of code here!!
    var answer = 42
    return answer
}

calculateTheMeaningofLife() * 9

NSHomeDirectory()

func displayLogon(name:String, status:String) {
    println("****************")
    println("Welcome \(name)")
    println("You have \(status) rights")
    println("==>")
}

displayLogon("Leon", "admin")

func degToRad(value:Double) -> Double {
    return value / 180 * M_PI
}

let NinetyRad = degToRad(90)

let OneEighty = degToRad(180)

let funnyAngle = degToRad(68.98)
