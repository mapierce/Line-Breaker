//
//  ViewController.swift
//  LineBreaker
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBAction func openSettingsTapped(_ sender: Any) {
        let url = URL(fileURLWithPath: "/System/Library/PreferencePanes/Extensions.prefPane")
        NSWorkspace.shared.open(url)
    }
    
}
