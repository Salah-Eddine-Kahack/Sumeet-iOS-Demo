//
//  ReachabilityHelper.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 12/04/2025.
//

import Network
import Combine


final class ReachabilityHelper {
    
    // MARK: - Singleton
    
    static let shared = ReachabilityHelper()
    
    // MARK: - Private properties
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.sumeet.ios.demo.ReachabilityHelper")
    private let hasInternetAccessSubject: CurrentValueSubject<Bool, Never> = .init(true) // Optimistic

    // MARK: - Publishers
    
    var hasInternetAccessPublisher: AnyPublisher<Bool, Never> {
        hasInternetAccessSubject.eraseToAnyPublisher()
    }

    // MARK: - Getters
    
    var hasInternetAccess: Bool {
        hasInternetAccessSubject.value
    }
    
    // MARK: - Lifecycle
    
    private init() {
        // Listen to changes
        monitor.pathUpdateHandler = { [weak self] path in
            
            guard let self else { return }
            
            DispatchQueue.main.async {
                let hasInternetAccess = (path.status == .satisfied)
                self.hasInternetAccessSubject.send(hasInternetAccess)
            }
        }
        
        // Start monitoring
        monitor.start(queue: queue)
    }
    
    deinit {
        // Stop monitoring
        monitor.cancel()
    }
}
