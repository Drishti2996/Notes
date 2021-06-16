//
//  ViewController.swift
//  NotesProject
//
//  Created by Local User on 04/04/21.
//  Copyright © 2021 Local User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var widgetView: DLWidgetView = {
        let view = DLWidgetView(frame: CGRect(x: 0, y: 300, width: 400, height: 200))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var anotherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(customView)
//        customView.backgroundColor = .cyan
//        customView.label.text = "1234567890"
        // Do any additional setup after loading the view.
        
        view.addSubview(widgetView)
        view.addSubview(anotherView)
        anotherView.backgroundColor = .red
        widgetView.backgroundColor = .cyan
        
        setConstraints()
        dispatchQueues()
    }

// You can’t update an app’s UI outside the main thread.
// A race condition occurs when two tasks are executed concurrently, when they should be executed sequentially in order to be done correctly. You cant change view constraint while it is being calculated. So UI activity should be done in main thread so it is executed sequentially.
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            anotherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            anotherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            anotherView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            anotherView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func dispatchQueues() {
        DispatchQueue.global(qos: .userInitiated).async {
            // download file or perform expenssive task
            print("****")
        }
        
        DispatchQueue.main.async {
            // perform UI task
            print("####")
        }
        
// A DispatchQueue is an abstraction layer on top of the GCD queue that allows you to perform tasks asynchronously and concurrently in your application.
        
// Grand Central Dispatch (GCD) is a low-level API for managing concurrent operations. It can help you improve your app’s responsiveness by deferring computationally expensive tasks to the background.
        
// synchronous queue - runs code serially
// and asyn queue - in random way
        
        /* serial queue - only one task at a time,  But task started(dispatched ) first, ends first your rest of the code is blocked till first task executed */
        let serialQueue = DispatchQueue(label: "swiftlee.serial.queue")
        // serial sync means every line executed the order it is written
        serialQueue.sync {
            print("1")
        }
        print("2")
        serialQueue.sync {
            print("3")
        }
        print("4")
        
        print("---------------")
        // serial async means task dispatchd first is executed first but it won't block rest of your code.
        //  your code will not wait for execution to complete. Both blocks will dispatch (and be enqueued) to the queue and the rest of your code will continue executing on that thread. Then at some point in the future, (depending on what else has been dispatched to your queue), Task 1 will execute and then Task 2 will execute.
        serialQueue.async {
                  print("5")
              }
              print("6")
              serialQueue.async {
                  print("7")
              }
              print("8")
        print("------------Concurent------------")
        
        /*  Concurrent Queue - all tasks start in the order they are added but executed in different threads which are managed by dispatch queue, so may not finish in the order started.
         */
        
        let concurrentQueue = DispatchQueue(label: "Concurrent queue", attributes: .concurrent)
        concurrentQueue.sync {
            print("a")
        }
        print("b")
        concurrentQueue.sync {
            print("c")
        }
        print("d")
        print("----------")
        concurrentQueue.async {
            print("e")
        }
        print("f")
        concurrentQueue.async {
            print("g")
        }
        
        concurrentQueue.sync(flags: .barrier) {
            // this task will be blocked till all previousl submitted tasks are executed.
            // this can be used on a queue which is doing write operation on a resource used by other queues.
        }
        print("h")
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: ({
            [weak self] in
            guard let _ = self else {
                return
            }
            print("qwerty")
        }))
    }
}

// NEVER run semaphore wait() function on main thread as it will freeze your app.

