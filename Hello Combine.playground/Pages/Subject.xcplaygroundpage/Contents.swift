import Foundation
import Combine


// CurrentValueSubject

let currentValueSubject = CurrentValueSubject<String, Never>("Initial text")

let subscription1 = currentValueSubject.sink { value in
    print("CurrentValueSubject value: \(value)")
}


// PassthroughSubject
let passthroughSubject = PassthroughSubject<String, Never>()

let subscription2 = passthroughSubject.sink { value in
    print("PassthroughSubject value: \(value)")
}

let subscription3 =  passthroughSubject.sink (receiveCompletion: { (result) in
    switch result {
    case .finished:
        print("finished")
    case .failure(let error):
        print(error.localizedDescription)
    }
}, receiveValue: { value in
    print("PassthroughSubject 데이터: \(value)")
})


passthroughSubject.send("Hello")
passthroughSubject.send("Sojin")


let publisher = ["Here", "we", "go"].publisher
publisher.subscribe(passthroughSubject)
publisher.subscribe(currentValueSubject)
