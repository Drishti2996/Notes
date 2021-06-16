import UIKit

/* Higher order functions */
 // Array type has a few methods that are higher order functions: sorted, map, filter, and reduce. These methods use closures to allow us to pass in functionality

/* 1. SORTED: elements should follow comparable protocol */
// sort changes value of same array. sorted gives new value
var no = [1,2,3,4, 0]
print(no.sort()) // sorts in ascending order
// to decide order on our own, use sort(by: )

// SYNTAX: 1
print(no.sorted{ a,b -> Bool in
    return a > b
})

print(no.sorted(by: > ))

//SYNTAX: 2
print(no.sorted(by: > ))
print(no.sorted{ $0 > $1 })

/* 2. MAP: maps through each element and changes value of each element */
print(no.map{ value in
    return value*2
})

// COMPACTMAP is similar to map. But in case of map if some value is not eligible, it will return nil. However, in compactMap, it returns only not nil values.
print(["1", "%"].compactMap{ Int($0)})

// FlatMap converts 2D array in 1D array
print([[1,2,3],[4,5,6]].flatMap{$0})

/* 3. FILTER - the filter method will return an array that has only elements that pass your filter specified in your closure. */
print(no.filter{ value in
    return (value%2 == 0)
})

print(no.filter{ $0%2 == 0 })

/* 4. REDUCE- */
print("ans:" + no.reduce("", {result, a  -> String in // 1 2 3 4 0
    print("r:" + result)
    print("a: \(a)")
    return result + String(a)
}))

print(no.reduce(""){ $0 + String($1)
    
})

/* FOREACH */
print(no.forEach{ value in
    if value == 2 {
    print("yes")
    }
})

// ----------- CLOSURE ------------
/*
 {(parameter) -> return type in
    statements
 }
 */

// SYNTAX: 1
var numb = no.sorted(by: {
    (a: Int, b: Int) -> Bool in
    return a > b
})

//SYNTAX: 2 (since parameters in functions, their types can be deduced. So, Int and bool removed)
 numb = no.sorted(by: { (a, b) in return a > b })

//SYNTAX: 3 SINGLE STATEMENT. SO, NO RETURN
numb = no.sorted(by: {a,b in a > b})

// SYNTAX: 4 shorthand parameter
numb = no.sorted(by: {$0 > $1})

// SYNTAX: 5 SHORTHAND
numb = no.sorted(by: > )

// function with closure as parameter
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// call the function with empty closure
someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// trailing closure
numb = no.sorted { $0 > $1 }

/* Call two closures as parameters in func*/

func abc(value: Bool, completion: (Int) -> Int, error: () -> Void) {
    if value {
        let new = completion(1)
        print(new)
    }else {
        error()
    }
}

abc(value: false, completion: {
    value in return value*2
}, error: {
    print("error")
})

// closures and functions are reference type. so assign one function to two variables, and they both will change same values

struct qwerty {
    var a: Int
    init(a: Int) {
        self.a = a
    }
}

var a = qwerty(a: 1)
var b = a

print(a.a)
print(b.a)
a.a = 2
print(a.a)
b.a = 3
print(b.a)
print(a.a)

// ------------------ escaping closures ------
// here closure is stored in an array. i.e. it will exist even after function returns. i.e it will escape the function. Thus, escaping closure.
var completionHandlers = [() -> Void]()
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
func someFunctionWithNonEscapingClosure(completionHandler:  () -> Void) {
}

// Now, if I have a self object in closure, and closure  stays after function escaped, strong reference. As Vc has closure and closure has VC. VC will leave closure, but closure still has VC. So, VC won't leave the memory.
// Thus use weak self

class SomeOtherClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure(completionHandler: { [weak self] in // captured self in closure as weak
            guard let strongSelf = self else {return}
            strongSelf.x = 200
        })
        
        /* SYNTAX2: since closure as last parameter
         someFunctionWithEscapingClosure { [weak self] in // captured self in closure as weak
             guard let strongSelf = self else {return}
             strongSelf.x = 200
         }
         */
    }
}
// escaping closures can’t capture a mutable reference to self for structures.

struct SomeOtherClass1 {
    var x = 10
    mutating func doSomething() { // can call non-escaping closure from mutating func if changes value of self.
        someFunctionWithNonEscapingClosure {
            x = 200
        }
    }
    
    mutating func doSomething1() { // can call non-escaping closure from mutating func if changes value of self.
           someFunctionWithEscapingClosure { [self] in // [weak self] not applicable as 'weak' may only be applied to class and class-bound protocol types, not 'SomeOtherClass1'
//            self.x = 200 // escaping closure cannot change self.
           }
    }
}


var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())!") // call closure as a function
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"
