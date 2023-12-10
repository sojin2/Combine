//: [Previous](@previous)

import Foundation
import Combine


// Basic CombineLatest

/*
 a          b        c
     1      2    3
     a,1    b,2  b,3 c,3 ==> 결과값
: 두개의 값이 모두 있어야 sink가 됨
: str과 num 값이 각각 바뀔때 가장 최신 값과 짝지어서 출력됨
 */

// 타입이 달라도 됨 
// 뭔가 짝?지어진 느낌?

let strPublisher = PassthroughSubject<String, Never>()
let numPublisher = PassthroughSubject<Int, Never>()

//1번
strPublisher.combineLatest(numPublisher).sink { (str, num) in
    print("Receive: \(str), \(num)")
}

//2번
Publishers.CombineLatest(strPublisher, numPublisher).sink { (str, num) in
    print("Receive: \(str), \(num)")
}

strPublisher.send("a")
numPublisher.send(1)
strPublisher.send("b")
numPublisher.send(2)
numPublisher.send(3)
strPublisher.send("c")

//strPublisher.send("a")
//strPublisher.send("b")
//strPublisher.send("c")

//numPublisher.send(1)
//numPublisher.send(2)
//numPublisher.send(3)



// Advanced CombineLatest

let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

let validatedCredentialsSubscrption = Publishers.CombineLatest(usernamePublisher, passwordPublisher)
    .map { (username, password) -> Bool in
        !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink{ valid in
        print("CombineLatest: are the credentials valid? \(valid)")
    }

usernamePublisher.send("sojin")
passwordPublisher.send("weakpw")
passwordPublisher.send("mystrongpassword")


// Merge
// 두개의 타입이 같아야 함
// 데이터가 줄 서는 느낌?

//let publisher1 = [1,2,3,4,5].publisher
//let publisher2 = [300,400,500].publisher
let publisher1 = ["1","2","3","4","5"].publisher
let publisher2 = ["300","400","500"].publisher

let mergedPublishersSubscription1 = publisher1.merge(with: publisher2)
    .sink { value in
        print("Merge: subscription1 received value \(value)")
}

//2번
let mergedPublishersSubscription2 = Publishers
    .Merge(publisher1, publisher2)
    .sink { value in
        print("Merge: subscription2 received value \(value)")
}

//: [Next](@next)
