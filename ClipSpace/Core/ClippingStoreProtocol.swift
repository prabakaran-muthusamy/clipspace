//
//  ClippingStoreProtocol.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Core/Protocols/ClippingStoreProtocol.swift

import Foundation

protocol ClippingStoreProtocol {
    func add(_ clipping: Clipping)
    func update(_ clipping: Clipping)
    func delete(id: UUID)
    func deleteAll()
    func fetch(query: String?) -> [Clipping]
    func prune(limit: Int)
}
