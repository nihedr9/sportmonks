//
//  Sportmonks.swift
//
//
//  Created by Nihed Majdoub on 20/02/2021.
//

import Vapor
@_exported import SportmonksKit

extension Application {
    public var sportmonks: SportMonksClient {
        guard let apiKey = Environment.get("SPORTMONKS_API_KEY") else {
            fatalError("SPORTMONKS_API_KEY env var required")
        }
        return .init(httpClient: http.client.shared,
                     eventLoop: eventLoopGroup.next(),
                     logger: logger,
                     apiKey: apiKey)
    }
}

extension Request {
    private struct SportMonksKey: StorageKey {
        typealias Value = SportMonksClient
    }
    public var sportmonks: SportMonksClient {
        if let existing = application.storage[SportMonksKey.self] {
            return existing.hopped(to: eventLoop)
        } else {
            guard let apiKey = Environment.get("SPORTMONKS_API_KEY") else {
                fatalError("SPORTMONKS_API_KEY env var required")
            }
            let new = SportMonksClient(httpClient: application.http.client.shared,
                                   eventLoop: eventLoop,
                                   logger: logger,
                                   apiKey: apiKey)
            self.application.storage[SportMonksKey.self] = new
            return new
        }
    }
}
