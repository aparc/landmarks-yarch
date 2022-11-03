//
//  Array.swift
//  Places
//
//  Created by Андрей Парчуков on 02.11.2022.
//


extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
