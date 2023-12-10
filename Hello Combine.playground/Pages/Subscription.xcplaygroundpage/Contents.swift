//: [Previous](@previous)

import Foundation
import Combine

let subject = PassthroughSubject<String, Never>()

// print() - 이벤트를 다 출력하고 싶을때 사용
let subscription1 = subject
    .print("[Debug]")
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
        print("에러나따")
        print(error.localizedDescription)
    }
}, receiveValue: { value in
    print("PassthroughSubject 데이터: \(value)")
})

subject2.send("Hello")
subject2.send(completion: .failure(SojinError.unknown))
subject2.send("Sojin")


