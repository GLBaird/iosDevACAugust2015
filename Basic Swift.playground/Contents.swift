
import Foundation

// Basic datatypes with variables

// operators

//  Assign         =

// Mathematical Operatos

// Addition        +
// Subtraction     -
// Multiplication  *
// Division        /
// Modulous        %

// Mathematical shorthands

// Add 1           ++
// Subtract 1      --

// Value shorthands
//                 +=
//                 -=
//                 *=
//                 /=
//                 %=

var myName = "Leon Baird"
var myAge = 40
var iLikePies = true


var companyName:String = "Pie Eaters INC"

myName = "Betty"
// myName = 3.14  (would cause error!)

// myAge = 50.9345 (would cause error -> double to int!)

// Maths

30 + 6

77 * 78

100 / 2

10 + 4 * 2

100 + 90 / 2

10 % 3

11 % 2

var ageIn10Years = myAge + 10

ageIn10Years

myAge = myAge - 1

// Shortand notations

myAge++

myAge

++myAge

myAge *= 2

myAge = 40

// Google C Maths Functions and Constants - M_...

sqrt(100.0)

M_PI

abs(-989)

// Concatination

myName + " Likes pies"

var dailyIntake = 6

var monthlyPies = 6 * 7 * 4.5

// Escape characters

"I get \"paid\" for this!"

"Do this tomorrow:\n\tThis first\n\tThis second"

"Today, \(myName) consumed \(dailyIntake) pies!"

// Conditional Operators

//  Equality        ==
//  Inequality      !=
//  Less than       <
//  Greater than    >
//  LT or Equals    <=
//  GT or Equals    >=

//  NOT             !

//  Total Equality    ===
//  Total Inequality  !==

//  Conditional Conjunctives

//  Conditional AND     &&
//  Conditional OR      ||

100 == 100

90 == 42

90 != 42

90 < 42

90 > 42

90 > 90

90 >= 90

10 == 10.0

10 === 10.0

var points = 10

var success = points > 30

!success

points > 60 && points < 80

points > 60 || points == 30
