//
//  Sportmonks.swift
//
//
//  Created by Nihed Majdoub on 20/02/2021.
//


import Vapor
import Sportmonks

extension Application {
    public var sportmonks: Sportmonks {
        guard let stripeKey = Environment.get("STRIPE_API_KEY") else {
            fatalError("STRIPE_API_KEY env var required")
        }
        return .init(httpClient: self.http.client.shared,
                     eventLoop: self.eventLoopGroup.next(),
                     apiKey: stripeKey)
    }
}

extension Request {
    private struct StripeKey: StorageKey {
        typealias Value = StripeClient
    }
    public var stripe: StripeClient {
        if let existing = application.storage[StripeKey.self] {
            return existing.hopped(to: self.eventLoop)
        } else {
            guard let stripeKey = Environment.get("STRIPE_API_KEY") else {
                fatalError("STRIPE_API_KEY env var required")
            }
            let new = StripeClient(httpClient: self.application.http.client.shared,
                                   eventLoop: self.eventLoop,
                                   apiKey: stripeKey)
            self.application.storage[StripeKey.self] = new
            return new
        }
    }
}
