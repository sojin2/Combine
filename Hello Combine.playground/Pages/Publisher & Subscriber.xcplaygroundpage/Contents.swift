//: [Previous](@previous)

import Foundation
import Combine

// Publisher & Subscriber

let subscription = Just("Hello").sink { value in
    print("바로 쓰기! : \(value)")
}

let publisher = Just("sojin")

let subscription1 = publisher.sink { value in
    print("Received Value: \(value)")
}

let subscription2 = publisher.sink (receiveCompletion: { (result) in
    switch result {
    case .finished:
        print("finished")
    case .failure(let error):
        print(error.localizedDescription)
    }
}, receiveValue: { (value) in
    print(value)
})


let arrayPublisher = [1, 3, 5, 7, 9].publisher

let subscription3 = arrayPublisher.sink { value in
    print("finished")
} receiveValue: { value in
    print("Received ArrayValue: \(value)")
}

class MyClass {
    var property: Int = 0 {
        didSet {
            print("Did set property to \(property)")
        }
    }
}

let object = MyClass()
//assign: object라는 객체에 있는 property라는 프로퍼티에 arrayPublisher 값을 세팅하겠다
let subscription4 = arrayPublisher.assign(to: \.property, on: object)

print("Final Value: \(object.property)")



class SojinSubscriber: Subscriber {
    
    typealias Input = Int
    typealias Failure = Never
    
    // 구독 완료
    func receive(subscription: Subscription) {
        print("구독 시작")
        subscription.request(.max(1))
    }
    
    // 구독자가 받을 것으로 예상하는 데이터 수를 나타내는 인스턴스
    func receive(_ input: Input) -> Subscribers.Demand {
        print("\(input)")
        
        switch input {
        case 0:
            return .max(2)
        default:
            return .none
        }
        
    }
    
    // 구독자에게 게시자가 정상적으로 또는 오류와 함께 게시를 완료했음을 알림
    func receive(completion: Subscribers.Completion<Never>) {
        print("완료", completion)
    }

}

arrayPublisher.subscribe(SojinSubscriber())



