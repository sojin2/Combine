import Foundation
import Combine


//PassthroughSubject
let passthroughSubject = PassthroughSubject<String, Never>()
let subscription2 = passthroughSubject.sink { value in
    print("PassthroughSubject value: \(value)")
}

passthroughSubject.send("Hello")
passthroughSubject.send("Sojin")

let subscription3 =  passthroughSubject.sink (receiveCompletion: { (result) in
    switch result {
    case .finished:
        print("finished")
    case .failure(let error):
        print(error.localizedDescription)
    }
}, receiveValue: { value in
    print("PassthroughSubject receiveValue: \(value)")
})


// CurrentValueSubject
let currentValueSubject = CurrentValueSubject<String, Never>("")

currentValueSubject.send("Initial text")

let subscription1 = currentValueSubject.sink { value in
    print("CurrentValueSubject value: \(value)")
}

currentValueSubject.send("More text")
// 지금 가지고 있는 값 보고 싶을 때
currentValueSubject.value



let publisher = ["Here", "we", "go"].publisher
publisher.subscribe(passthroughSubject)
publisher.subscribe(currentValueSubject)
