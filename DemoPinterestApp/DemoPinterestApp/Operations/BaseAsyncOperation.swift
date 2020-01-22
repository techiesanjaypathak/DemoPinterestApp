//
//  BaseAsyncOperation.swift
//  DemoPinterestApp
//
//  Created by SanjayPathak on 22/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation

class BaseAsyncOperation:Operation{
    
    override var isAsynchronous: Bool{
        return true
    }
    
    enum State:String{
        case Ready
        case Executing
        case Finished
        
        fileprivate var keyPath:String{
            return "is" + rawValue
        }
    }
    
    var state = State.Ready {
        willSet{
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet{
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
}

extension BaseAsyncOperation{
    
    override var isReady: Bool{
        return super.isReady && state == .Ready
    }
    
    override var isExecuting: Bool{
        return state == .Executing
    }
    
    override var isFinished: Bool{
        return state == .Finished
    }
    
    override func start() {
        if isCancelled{
            state = .Finished
            return
        }
        main()
        state = .Executing
    }
    
    override func cancel() {
        state = .Finished
    }
}
