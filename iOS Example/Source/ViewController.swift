//
//  ViewController.swift
//  iOS Example
//
//  Created by Horst Leung on 2017-01-16.
//  Copyright © 2017 VDelegate Limited. All rights reserved.
//

import UIKit
import JustJson

class ViewController: UIViewController {
    
    var dict: [String: Any] = [
        "language": "de",
        "translator": "Erika Fuchs",
        "translations": [
            "characters": [
                "Scrooge McDuck": "Dagobert",
                "Huey": "Tick",
                "Dewey": "Trick",
                "Louie": "Track",
                "Gyro Gearloose": "Daniel Düsentrieb",
            ],
            "places": [
                "Duckburg": "Entenhausen",
                "Money Bin": "Geldspeicher",
            ]
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(dict[string: "translations.characters.Gyro Gearloose"] ?? "invalid dictionary")
        print(dict.toJSONStr() )
        print(dict.toJSONStr()?.toDictionary())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

