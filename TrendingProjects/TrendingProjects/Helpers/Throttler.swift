//
//  Throttler.swift
//  TrendingProjects
//
//  Created by Elene_Akhvlediani on 7/10/21.
//

import Foundation
final class Throttler {

    private let queue: DispatchQueue = DispatchQueue.global(qos: .background)

    private var job: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private var maxInterval: Double

    init(seconds: Double) {
        maxInterval = seconds
    }

    func throttle(block: @escaping () -> ()) {
        job.cancel()
        job = DispatchWorkItem(){ [weak self] in
            self?.previousRun = Date()
            block()
        }
        let delay = Date.second(from: previousRun) > maxInterval ? 0 : maxInterval
        queue.asyncAfter(deadline: .now() + Double(delay), execute: job)
    }
}

private extension Date {
    static func second(from referenceDate: Date) -> Double {
        return Date().timeIntervalSince(referenceDate).rounded()
    }
}
