//: Playground - noun: a place where people can play

import Foundation

// Collections
// Arrays

let partyInvites = ["Mary", "Pete", "Brian", "Sue", "Jane"]

// number of items in array
partyInvites.count

partyInvites[0]
partyInvites[3]

partyInvites.last
partyInvites.first

// mutable
var favouriteFood:[String] = ["Pies", "Pasites", "Big pies", "Huge pies"]

favouriteFood.count

// push popping
favouriteFood.append("Small pies")

favouriteFood.count

favouriteFood[1] = "Cow Pie"

favouriteFood


var recordNumber = 1
var newValue = "Cheese"

favouriteFood[recordNumber] = newValue


favouriteFood.removeAtIndex(recordNumber)


// loops

// for while do

for var i = 0; i < partyInvites.count; i++ {
    println("Index #\(i)")
    println(partyInvites[i] + " You are invited to my part")
}

for name in partyInvites {
    println("Hi there \(name)")
}


for i in 0...1000 {
    sinf(Float(i)/50)
}

// Dictionary

// myDictionary["surname"]

// Set - no index

// AnyObject


var anyThing:[AnyObject] = [10, 20, 30, 40, 50]

var value = anyThing[2] as! Int








