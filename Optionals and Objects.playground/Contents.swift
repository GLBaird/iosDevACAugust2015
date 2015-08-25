//: Playground - noun: a place where people can play

import Foundation

// Optionals

var downloadedData:String?

downloadedData = "Stuff from the internet"

if downloadedData != nil {
    println("The data has arrived!")
    println("The data is \(downloadedData!)")
}

// if data?.item?.stuff

// downloadedData?.display()

if let data = downloadedData {
    println("The data arrived \(data)")
}

var willExist:String!


