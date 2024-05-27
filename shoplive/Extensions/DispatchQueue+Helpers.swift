//
//  DispatchQueue+Helpers.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Foundation

func asyncOn<T: AnyObject>(queue: DispatchQueue =  .global(), deadline: DispatchTimeInterval = .never, with context: T, _ block: @escaping (T) -> Void) {
    queue.asyncAfter(deadline: .now().advanced(by: deadline)) { [weak context] in
        guard let context else { return }
        block(context)
    }
}

func asyncOn(queue: DispatchQueue =  .global(), deadline: DispatchTimeInterval = .never, _ block: @escaping () -> Void) {
    queue.asyncAfter(deadline: .now().advanced(by: deadline)) {
        block()
    }
}


func asyncOnMain<T: AnyObject>(deadline: DispatchTimeInterval = .never, with context: T, _ block: @escaping (T) -> Void) {
    asyncOn(queue: .main, with: context, block)
}

func asyncOnGlobal<T: AnyObject>(deadline: DispatchTimeInterval = .never, with context: T, _ block: @escaping (T) -> Void) {
    asyncOn(deadline: deadline, with: context, block)
}

func asyncOnGlobal(deadline: DispatchTimeInterval = .never, _ block: @escaping () -> Void) {
    asyncOn(deadline: deadline, block)
}



