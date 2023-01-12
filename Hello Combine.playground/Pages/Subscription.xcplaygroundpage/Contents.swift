//: [Previous](@previous)

import Foundation
import Combine

let subject = PassthroughSubject<String, Never>()

// The print() operator prints you all lifecycle events
let subscription1 = subject
    .print()
    .sink { value in
        print("Subscriber received value: \(value)")
    }

subject.send("Hello")
subject.send(completion: .finished)
// subscription1.cancel()
subject.send("Sojin")


// subject .failure
enum SojinError: Error {
    case unknown
}

let subject2 = PassthroughSubject<String, Error>()

let subscription3 =  subject2.sink (receiveCompletion: { (result) in
    switch result {
    case .finished:
        print("finished")
    case .failure(let error):
        print("에러 삐용삐용")
        print(error.localizedDescription)
    }
}, receiveValue: { value in
    print("PassthroughSubject 데이터: \(value)")
})

subject2.send("Hello")
subject2.send(completion: .failure(SojinError.unknown))
subject2.send("Sojin")



//: [Next](@next)
