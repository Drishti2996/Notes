import UIKit

var str = "Hello, playground"
/* STATIC & CLASS VARIABLES */

// You indicate type methods by writing the static keyword before the method’s func keyword. Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that method.

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    // type func can access type variable within its body without type name prefix. like highestUnlockedLevel called without Levelracker.highestUnlockedLevel
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
          return level <= highestUnlockedLevel
      }
    
    @discardableResult // An attribute provides additional information about the declaration or type. For example, the discardableResult attribute on a function declaration indicates that, although the function returns a value, the compiler shouldn’t generate a warning if the return value is unused.
    // mutating because this function is updating a value of struct
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

// As with type property requirements, you always prefix type method requirements with the static keyword when they’re defined in a protocol. This is true even though type method requirements are prefixed with the class or static keyword when implemented by a class:

protocol SomeProtocol: class {
    static func someTypeMethod()
    static func otherTypeMethod()
}


class ABC: SomeProtocol {
    // class func is a static func for class, but it also mentions that this func can be overriden by sub-class; final class fuc == static func
    class func someTypeMethod() {
        print("this means someTypeMethod is an type method which can be inherited by ABC subClass")
    }
    
    // static func, on the other hand, cannot be overriden
    static func otherTypeMethod() {
        
    }
}

class SubClass: ABC {
   override class func someTypeMethod() {
        
    }
    
   override static func otherTypeMethod() {
        
    }
}
//---------------
/* PROTOCOL */
protocol SomeProtocolWithInit {
    init(someParameter: Int)
}

class SomeClass: SomeProtocolWithInit {
    // required initializers are those which should be marked with inits which are must to implement in further sub-classes.
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}

// Protocols can be passed as parameters to functions
protocol RandomNumberGenerator {
    func random() -> Double
}

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}


 var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator()) // LinearCongruentialGenerator is any class which has implemented RandomGenerator
 for _ in 1...5 {
     print("Random dice roll is \(d6.roll())")
 }

//ANYOBJECT
//You can limit protocol adoption to class types (and not structures or enumerations) by adding the AnyObject protocol to a protocol’s inheritance list.
protocol SomeClassOnlyProtocol: AnyObject {
    // class-only protocol definition goes here
}

// by protocol extension, we can provide a default value of protocol.

// it means we applied contraints to Collection protocol. i.e. we can use function defined in the extension of protocol only if elements of protocol are equatable.
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

// Another example
//The following extension makes Array instances conform to the TextRepresentable protocol whenever they store elements of a type that conforms to TextRepresentable.
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
//If a type already conforms to all of the requirements of a protocol, but hasn’t yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {} // is same as struct Hmster: TextRepresentable { var text: String}

// MARK:- read:  Adopting a Protocol Using a Synthesized Implementation

