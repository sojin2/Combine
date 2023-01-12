import Foundation
import Combine


// CurrentValueSubject

let variable = CurrentValueSubject<String, Never>("Initial text")

let subscription2 = variable.sink { value in
    print("CurrentValueSubject value: \(value)")
}


// PassthroughSubject
let passthroughSubject = PassthroughSubject<String, Never>()


let subscription1 = passthroughSubject.sink { value in
    print("PassthroughSubject value: \(value)")
}

passthroughSubject.send("Hello")
passthroughSubject.send("Sojin")


let publisher = ["Here", "we", "go"].publisher
publisher.subscribe(passthroughSubject)
publisher.subscribe(variable)



enum SojinError: Error {
    case unknown
}

let relay = PassthroughSubject<String, Error>()

let subscription3 =  relay.sink (receiveCompletion: { (result) in
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

relay.send("Hello")
// relay.send(completion: .failure(SojinError.unknown))
relay.send(completion: .finished)
relay.send("Sojin")

