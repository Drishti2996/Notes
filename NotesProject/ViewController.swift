//
//  ViewController.swift
//  NotesProject
//
//  Created by Local User on 04/04/21.
//  Copyright © 2021 Local User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var customView = MyCustomView(frame: CGRect(x: 0, y: 300, width: 400, height: 200))
    private var widgetView: DLWidgetView = {
        let view = DLWidgetView(frame: CGRect(x: 0, y: 300, width: 400, height: 200))
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(customView)
//        customView.backgroundColor = .cyan
//        customView.label.text = "1234567890"
        // Do any additional setup after loading the view.
        
        view.addSubview(widgetView)
        widgetView.backgroundColor = .cyan
    }


}

