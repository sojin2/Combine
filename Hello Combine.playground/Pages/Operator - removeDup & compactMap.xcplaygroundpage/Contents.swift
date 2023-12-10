//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

// removeDuplicates
// 저 반복되는거 안 받아여~~

let words = "hey hey there! Mr Mr ?"
    .components(separatedBy: " ")
    .publisher

words
    .removeDuplicates()
    .sink(receiveValue: {
        print($0)
    }).store(in: &subscriptions)


// compactMap
// 특정 타입으로 전환해주는데 전환 되는 것만 나한테 줘!!

let strings = ["a", "1.24", "3", "def", "45", "0.23"].publisher

strings
    .compactMap { Float($0) }
    .sink (receiveValue: {
        print($0)
    })
    .store(in: &subscriptions)


// ignoreOutput
// output을 무시할꺼야!

let numbers = (1...10_000).publisher

numbers
    .ignoreOutput()
    .sink(receiveCompletion: { print("Completed with: \($0)")}, receiveValue: { print($0) })
    .store(in: &subscriptions)


// prefix
// 내가 설정한 갯수의 값만 받을꺼야!

let tens = (1...10).publisher

tens
    .prefix(2)
    .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscriptions)

//: [Next](@next)
