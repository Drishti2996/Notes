import UIKit

var str = "Hello, playground"

let names = ["abc", "qwe", "asd"]
for name in names {
    print(name)
}

// content of dictionary are inodered. So, won't return 1,2,3 but in any order
let dictionary = ["value1": 1, "value2": 2, "value3": 3]
for (key,value) in dictionary {
    print("\(key): \(value)")
}

for index in 1...3 {
    print(names[index-1])
}

for index in 1..<3 {
    print(index)
}

//excluding 11
for ndex in stride(from: 1, to: 11, by: 5){
    print(ndex)
}

// including 11
for ndex in stride(from: 1, through: 11, by: 5){
    print(ndex)
}

while true == false {
    print("oh my god!!!")
}
var count = 0
repeat {
  print(count)
    count += 1
} while count != 2

let point = (2,1)
switch point {
case (let x, 1):
    print(x)
case (2, let y):
    print(y)
case let(x,y) where x == 2:
    print("123")
case (_,_):
    print("123")
}


var person: UILabel? {
    willSet{
        
    }
    didSet{
        
    }
}

var name: String = {
    let name = "asdf"
    return name + "qwer"
}()

enum BarCode {
    case upc(Int, Int, Int)
    case code(String)
}
let value = BarCode.upc(7,7,7)
switch value {
case .upc(let x, let y, _):
    break
case .code(_):
    break
}

/*
 1. classes have deinitializers
 2. classes are reference type and struct are value type
 
 when to use class?
 * when impplement protocol of class type
 * when implement NSObjects or objective-c related objects
 *
  use struct when simple dataTypes
 
 string, aray, dict are struct
 */

// Lazy properties are useful when the initial value for a property is dependent on outside factors whose values aren’t known until after an instance’s initialization is complete. Lazy properties are also useful when the initial value for a property requires complex or computationally expensive setup that shouldn’t be performed unless or until it’s needed.

// computed properties are where we do some action. However we have to explicitly mention getter setter. If only value returned in computed property, it becomes read-only propery
 var volume: Double {
    return 23.0
    }


private var number: Int 
